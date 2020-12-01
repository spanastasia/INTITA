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

class ProfileViewController: UIViewController, Storyboarded {
    private let rowNumber = 5
    private let alert: AlertView = .fromNib()
    private var initialHeaderHeight: CGFloat = 0
    private var headerState = HeaderState.normal
    private var currentTableViewContentYOffset: CGFloat = 0
    weak var coordinator: ProfileCoordinator?
    var viewModel: ProfileViewModel?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableViewWrapper: UIView!
    lazy var headerContentView: ProfileHeaderViewCell = .fromNib()
    lazy var animator = UIViewPropertyAnimator()
    lazy var gestureRecognizer = UIPanGestureRecognizer()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        view.addSubview(alert)
        
        viewModel?.delegate = self
        viewModel?.subscribe(updateCallback: handleError)
        
        tableView.dataSource = self
        tableView.delegate = self
        registerCells()
        
        headerContentView.delegate = coordinator
        
        initialHeaderHeight = headerContentView.frame.height

        animator.isInterruptible = true
        gestureRecognizer.addTarget(self, action: #selector(handleGesture))
        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        headerView.frame.size.width = view.safeAreaLayoutGuide.layoutFrame.width
        headerContentView.frame = headerView.bounds
        headerView.addSubview(headerContentView)
    }
    
    
    //MARK: - Error handling
    func handleError(error: Error) {
        DispatchQueue.main.async {
            self.stopSpinner()
            self.alert.customizeAndShow(message: error.localizedDescription)
        }
    }
    
    //MARK: - Private methods
    private func registerCells() {
        tableView.register(UINib(nibName: "ProfileHeaderViewCell", bundle: nil), forCellReuseIdentifier: "ProfileHeaderViewCell")
        tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        tableView.register(UINib(nibName: "ProfileFooterViewCell", bundle: nil), forCellReuseIdentifier: "ProfileFooterViewCell")
    }
    @objc func handleGesture(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            currentTableViewContentYOffset = tableView.contentOffset.y
            initializeAnimator()
            animator.startAnimation()
            animator.pauseAnimation()
        case .changed:
            switch headerState {
            case .normal:
                animator.fractionComplete = -gesture.translation(in: view).y / 100
            case .decreased:
                if tableView.contentOffset.y <= 100 {
                    animator.fractionComplete = gesture.translation(in: view).y / 100
                }
            }
            if -gesture.translation(in: view).y + currentTableViewContentYOffset > 0, -gesture.translation(in: view).y + currentTableViewContentYOffset < tableView.contentSize.height - tableView.bounds.size.height {
                tableView.contentOffset.y = -gesture.translation(in: view).y + currentTableViewContentYOffset
            }
            
        case .ended:
            if animator.fractionComplete >= 0.5 {
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
                headerState.toggle()
            } else {
                animator.isReversed = true
                animator.startAnimation()
                if headerState == .normal {
                    tableView.setContentOffset(CGPoint(x: 0, y: currentTableViewContentYOffset), animated: true)
                } else {
                    tableView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
                }
            }
            animator.addCompletion { [unowned self]_ in
                var opacity: Float = 0
                switch headerState {
                case .decreased:
                    opacity = 0
                case .normal:
                    opacity = 1
                }
                headerContentView.layer.sublayers?[3].opacity = opacity
                headerContentView.layer.sublayers?[4].opacity = opacity
                headerContentView.layer.sublayers?[5].opacity = opacity
            }
        default:
            break
        }
    }
    
    private func initializeAnimator() {
        animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear) { [unowned self] in
            switch headerState {
            case .normal:
                headerView.transform = CGAffineTransform.identity
                    .scaledBy(x: 1, y: 0.5)
                    .translatedBy(x: 0, y: -headerView.frame.height * 0.5)
                headerContentView.avatarView.transform = CGAffineTransform.identity
                    .scaledBy(x: 0.5, y: 1)
                    .translatedBy(x: 0, y: -headerContentView.logoView.frame.height - 16)
                headerContentView.nameLabel.transform = CGAffineTransform.identity
                    .scaledBy(x: 1, y: 2)
                    .translatedBy(x: 0, y: -headerContentView.logoView.frame.height)
                headerContentView.specializationLabel.transform = CGAffineTransform.identity
                    .scaledBy(x: 1, y: 2)
                    .translatedBy(x: 0, y: -headerContentView.logoView.frame.height + 8)
                headerContentView.editButton.transform = CGAffineTransform.identity
                    .translatedBy(x: 70, y: 0)
                    .scaledBy(x: 0.001, y: 0.001)
                
                headerContentView.layer.sublayers?[3].opacity = 0
                headerContentView.layer.sublayers?[4].opacity = 0
                headerContentView.layer.sublayers?[5].opacity = 0
                
                headerContentView.logoView.transform = CGAffineTransform.identity
                .scaledBy(x: 0.001, y: 0.001)
                headerContentView.logoView.layer.opacity = 0
                headerContentView.editButton.layer.opacity = 0
                
                tableView.transform = CGAffineTransform.identity
                    .translatedBy(x: 0, y: -headerView.frame.height)
                tableView.frame.size.height += headerContentView.frame.height / 2
            case .decreased:
                let transform = CGAffineTransform.identity.inverted()
                headerView.transform = transform
                headerContentView.avatarView.transform = transform
                headerContentView.nameLabel.transform = transform
                headerContentView.specializationLabel.transform = transform
                headerContentView.logoView.transform = transform
                headerContentView.editButton.transform = transform
                
                headerContentView.logoView.layer.opacity = 1
                headerContentView.editButton.layer.opacity = 1
                
                tableView.transform = CGAffineTransform.identity.inverted()
                tableView.frame.size.height -= headerContentView.frame.height / 2
                
            }
            view.layoutSubviews()
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileFooterViewCell") as? ProfileFooterViewCell
            cell?.label.text = "exit".localized
            cell?.delegate = viewModel
            currentCell = cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell
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
            return 86
        default:
            return 99
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
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
        alert.customizeAndShow(header: "Oops...", message: "Coming soon", buttonTitle: "Got it")
    }
    
}

extension ProfileViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
}
