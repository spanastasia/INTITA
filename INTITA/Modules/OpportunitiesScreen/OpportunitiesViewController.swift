//
//  OpportunitiesViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 24.01.2021.
//

import UIKit

class OpportunitiesViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var courseView: UIView!
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var studiesView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var availableOptionsLabel: UILabel!
    
    @IBOutlet weak var heightOfCourseView: NSLayoutConstraint!
    @IBOutlet weak var heightOfStudiesView: NSLayoutConstraint!
    @IBOutlet weak var heightOfTaskView: NSLayoutConstraint!
    
    var coordinator: OpportunitiesCoordinator?
    var isProfileSize = true
    var tape: OpportunitiesView?
    
    private lazy var contentCourseView: OpportunitiesTableViewCell = .fromNib()
    private lazy var contentTaskView: OpportunitiesTableViewCell = .fromNib()
    private lazy var contentStudiesView: OpportunitiesTableViewCell = .fromNib()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupNameLabel()
        setupAvailableOptionsLabel()
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        setupView(withType: OpportunitiesView.task, view: contentCourseView)
//        setupCourseView()
//        setupTaskView()
//        setupStudiesView()

    }
    
    func setupNameLabel() {
        nameLabel.text = "opportunities".localized
    }
    
    func setupAvailableOptionsLabel() {
        availableOptionsLabel.text = "available_options".localized
    }
    
    func setupView(withType: OpportunitiesView, view: UIView) {
        
//        view.type = withType
//        view.delegate = self
//        view.isProfileSize = isProfileSize
//        courseView.addSubview(view)
    }
    
    func setupCourseView() {

        contentCourseView.type = .course
        contentCourseView.delegate = self
        contentCourseView.isProfileSize = isProfileSize
        courseView.addSubview(contentCourseView)
    }
    
    func setupTaskView() {

        contentTaskView.type = .task
        contentTaskView.delegate = self
        contentTaskView.isProfileSize = isProfileSize
        taskView.addSubview(contentTaskView)
    }
    
    func setupStudiesView() {

        contentStudiesView.type = .study
        contentStudiesView.delegate = self
        contentStudiesView.isProfileSize = isProfileSize
        studiesView.addSubview(contentStudiesView)
    }
    
    @IBAction func backButtonTappet(_ sender: UIButton) {
        
        coordinator?.returnToProfileScreen()
    }
    
}

extension OpportunitiesViewController: OpportunitiesTableViewCellDelegate {
    
    func reduceHeightOfView(withType: OpportunitiesView) {
//        print("reduceHeightOfView")
        switch withType {
        case .course:
//            print("course")
            heightOfCourseView.constant = 75
            contentCourseView.configureSmallView()
        case .task:
//            print("task")
            heightOfTaskView.constant = 75
            contentTaskView.configureSmallView()
        case .study:
//            print("study")
            heightOfStudiesView.constant = 75
            contentStudiesView.configureSmallView()
        }
        
        isProfileSize.toggle()
    }
    
    func increaseHeightOfView(withType: OpportunitiesView) {

        switch withType {
        case .course:
//            print("course")
            heightOfCourseView.constant = 120
            contentCourseView.configureExtendedView()
        case .task:
//            print("task")
            heightOfTaskView.constant = 120
            contentTaskView.configureExtendedView()
        case .study:
//            print("study")
            heightOfStudiesView.constant = 120
            contentStudiesView.configureExtendedView()
        }
        
        isProfileSize.toggle()
    }
        
}

extension OpportunitiesViewController: UITableViewDataSource {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return Opportunities.allCases.count
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Opportunities.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            <#code#>
        case 1:
            <#code#>
        case 2:
            <#code#>
        default:
            <#code#>
        }
        
        return UITableViewCell()
    }
    
}

extension OpportunitiesViewController: UITableViewDelegate {
    
}
