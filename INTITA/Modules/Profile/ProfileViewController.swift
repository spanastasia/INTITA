//
//  ProfileViewController.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 13.11.2020.
//

import UIKit

enum HeaderState {
    case normal
    case decreased
    
    mutating func toggle() {
        switch self {
        case .normal:
            self = .decreased
        case .decreased:
            self = .normal
        }
    }
}

class ProfileViewController: UIViewController, Storyboarded, AlertAcceptable {
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    private let rowNumber = 5
    private var initialHeaderHeight: CGFloat = 0
    private var headerState = HeaderState.normal
    private var currentTableViewContentYOffset: CGFloat = 0
    
    weak var coordinator: ProfileCoordinator?
    var viewModel: ProfileViewModel?
    
    private lazy var headerContentView: ProfileHeaderViewCell = .fromNib()
    private lazy var animator = UIViewPropertyAnimator()
    private lazy var gestureRecognizer = UIPanGestureRecognizer()
    private lazy var refreshControl = UIRefreshControl()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        viewModel?.delegate = self
        viewModel?.subscribe { error in
            DispatchQueue.main.async {
                self.updateCallback(error: error)
            }
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        registerCells()
        
        headerContentView.delegate = coordinator
        
        initialHeaderHeight = headerContentView.frame.height

        animator.isInterruptible = true
        gestureRecognizer.addTarget(self, action: #selector(handleGesture))
        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)
        
        headerView.addSubview(headerContentView)
        headerContentView.translatesAutoresizingMaskIntoConstraints = false
        headerContentView.shadowed(shadowOffset: CGSize(width: 0, height: 7))
        
        tableView.addSubview(refreshControl)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        headerContentView.frame.size.width = view.frame.width
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: - Error handling
    func updateCallback(error: Error?) {
        stopSpinner()
        refreshControl.endRefreshing()
        if let error = error {
            self.showAlert(message: error.localizedDescription)
            return
        }
        headerContentView.update()
    }
    
    //MARK: - Private methods
    private func registerCells() {
        tableView.register(ProfileTableViewCell.nib(), forCellReuseIdentifier: ProfileTableViewCell.identifier)
        tableView.register(ProfileFooterViewCell.nib(), forCellReuseIdentifier: ProfileFooterViewCell.identifier)
    }
    
    @objc func handleGesture(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            currentTableViewContentYOffset = tableView.contentOffset.y
            initializeAnimator()
        case .changed:
            switch headerState {
            case .normal:
                if animator.fractionComplete > 0 {
                    animator.fractionComplete = -gesture.translation(in: view).y / 100
                } else if gesture.translation(in: view).y < 0, tableView.frame.height <= tableView.contentSize.height + 16 {
                    animator.startAnimation()
                    animator.pauseAnimation()
                    animator.fractionComplete = -gesture.translation(in: view).y / 100
                } else if gesture.translation(in: view).y > 0, !animator.isRunning {
                    tableView.contentOffset.y = gesture.translation(in: view).y > 100 ? -100 : -gesture.translation(in: view).y
                    currentTableViewContentYOffset = -36
                }
            case .decreased:
                if tableView.contentOffset.y <= 100, animator.fractionComplete > 0 {
                    animator.fractionComplete = (gesture.translation(in: view).y - currentTableViewContentYOffset) / 100
                } else if gesture.translation(in: view).y > 0, tableView.contentOffset.y < 32 {
                    animator.startAnimation()
                    animator.pauseAnimation()
                    animator.fractionComplete = (gesture.translation(in: view).y - currentTableViewContentYOffset) / 100
                }
            }
            if currentTableViewContentYOffset - gesture.translation(in: view).y > 0, currentTableViewContentYOffset - gesture.translation(in: view).y < tableView.contentSize.height - tableView.frame.height, headerState == HeaderState.decreased {
                tableView.contentOffset.y = currentTableViewContentYOffset - gesture.translation(in: view).y
            }
            view.layoutIfNeeded()
        case .ended:
            if gesture.translation(in: view).y > 50, headerState == HeaderState.normal {
                refreshControl.beginRefreshing()
                tableView.refreshControl?.beginRefreshing()
                viewModel?.fetchUser()
            }
            if animator.fractionComplete >= 0.5 {
                completeAnimation()
                headerState.toggle()
            } else {
                reverseAnimation()
            }
            animator.addCompletion { [weak self]_ in
                guard let self = self else { return }
                var height: CGFloat
                switch self.headerState {
                case .decreased:
                    height = 158
                case .normal:
                    height = 316
                }
                self.headerViewHeightConstraint.constant = height
                self.tableViewBottomConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        default:
            break
        }
    }
    
    private func initializeAnimator() {
        animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear) { [weak self] in
            guard let self = self else { return }
            
            let widthHeaderContentView = self.headerContentView.frame.width
            let heightHeaderContentView = self.headerContentView.frame.height
            
            switch self.headerState {
            case .normal:
                self.headerContentView.transform = CGAffineTransform.identity
                    .scaledBy(x: 1, y: 0.5)
                    .translatedBy(x: 0, y: -self.headerContentView.frame.height / 2)
                
                self.headerContentView.avatarWrapper.transform = CGAffineTransform.identity
                    .translatedBy(x: -0.3 * widthHeaderContentView,
                                  y: -0.05 * heightHeaderContentView)
                    .scaledBy(x: 0.7, y: 1.4)
                
                self.headerContentView.avatarView.transform = CGAffineTransform.identity
                    .translatedBy(x: -0.3 * widthHeaderContentView,
                                  y: -0.05 * heightHeaderContentView)
                    .scaledBy(x: 0.7, y: 1.4)
                
                self.headerContentView.editButton.transform = CGAffineTransform.identity
                    .translatedBy(x: 70, y: 0)
                    .scaledBy(x: 0.001, y: 0.001)
                
                self.headerContentView.logoView.transform = CGAffineTransform.identity
                    .scaledBy(x: 0.001, y: 0.001)
                let xShift = self.headerContentView.surnameLabel.frame.minX - self.headerContentView.nameLabel.frame.minX
                self.headerContentView.nameLabel.transform = CGAffineTransform.identity
                    .scaledBy(x: 1, y: 2)
                    .translatedBy(x: -0.1 * widthHeaderContentView + xShift,
                                  y: -0.1 * heightHeaderContentView)

                self.headerContentView.surnameLabel.transform = CGAffineTransform.identity
                    .scaledBy(x: 1, y: 2)
                    .translatedBy(x: -0.1 * widthHeaderContentView,
                                  y: -0.25 * heightHeaderContentView)
                
                self.headerContentView.specializationLabel.transform = CGAffineTransform.identity
                    .scaledBy(x: 1, y: 2)
                    .translatedBy(x: 0, y: -8)
                
                self.headerContentView.logoView.layer.opacity = 0
                self.headerContentView.editButton.layer.opacity = 0
                
                self.headerViewHeightConstraint.constant = 158
                
            case .decreased:
                let transform = CGAffineTransform.identity.inverted()
                self.headerContentView.transform = transform
                self.headerContentView.avatarView.transform = transform
                self.headerContentView.avatarWrapper.transform = transform
                self.headerContentView.logoView.transform = transform
                self.headerContentView.editButton.transform = transform
                self.headerContentView.nameLabel.transform = transform
                self.headerContentView.surnameLabel.transform = transform
                self.headerContentView.specializationLabel.transform = transform
                
                self.headerContentView.logoView.layer.opacity = 1
                self.headerContentView.editButton.layer.opacity = 1
                
                self.headerViewHeightConstraint.constant = 316
                
                self.tableViewBottomConstraint.constant = 158
            }
            self.view.layoutSubviews()
        }
    }
    private func completeAnimation() {
        animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        switch headerState {
        case .normal:
            if tableView.contentOffset.y < 100 + currentTableViewContentYOffset {
                if tableView.contentOffset.y + 100 + currentTableViewContentYOffset < tableView.contentSize.height - tableView.bounds.size.height {
                    tableView.setContentOffset(CGPoint(x: 0, y: tableView.contentOffset.y - currentTableViewContentYOffset + 100), animated: true)
                } else {
                    tableView.scrollToRow(at: IndexPath(row: 4, section: 0), at: .bottom, animated: true)
                }
            }
        case .decreased:
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    private func reverseAnimation() {
        animator.isReversed = true
        animator.startAnimation()
        if headerState == .normal {
            tableView.setContentOffset(CGPoint(x: 0, y: currentTableViewContentYOffset), animated: true)
        }
    }
}

//MARK: - Extentions
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowNumber
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        var currentCell: UITableViewCell?
        switch row {
        case rowNumber - 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileFooterViewCell.identifier) as? ProfileFooterViewCell
            cell?.label.text = "exit".localized
            cell?.delegate = viewModel
            currentCell = cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as? ProfileTableViewCell
            setUpProfileBodyCell(cell, row: row)
            currentCell = cell
        }
        return currentCell ?? UITableViewCell()
    }
    
    private func setUpProfileBodyCell(_ cell: ProfileTableViewCell?, row: Int) {
        cell?.row = row
        cell?.delegate = coordinator
        if row == 0 {
            cell?.button.imageView?.image = UIImage(named: "mail")
            cell?.label.text = "messages".localized
        }
        if row == 1 {
            cell?.button.imageView?.image = UIImage(named: "trophy")
            cell?.label.text = "opportunities".localized
        }
        if row == 2 {
            cell?.button.imageView?.image = UIImage(named: "edit")
            cell?.label.text = "my tasks".localized
        }
        if row == 3 {
            cell?.button.imageView?.image = UIImage(named: "settings")
            cell?.label.text = "settings".localized
        }
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case rowNumber - 1:
            return 106
        default:
            return 99
        }
    }
}

extension ProfileViewController: ProfileViewModelDelegate {
    func logoutSuccess() {
        DispatchQueue.main.async {
            self.stopSpinner()
            self.coordinator?.showLoginScreen()
        }
    }
}

extension ProfileViewController: ProfileCoordinatorAlertPresenter {
    func showAlert() {
        showAlert(header: "Oops!", message: "comming_soon".localized)
    }
    
}

extension ProfileViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
}
