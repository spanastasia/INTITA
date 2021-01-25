//
//  OpportunitiesViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 24.01.2021.
//

import UIKit

class OpportunitiesViewController: UIViewController, Storyboarded {
    
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
        
        setupCourseView()
        setupTaskView()
        setupStudiesView()

    }
    
    func setupNameLabel() {
        nameLabel.text = "opportunities".localized
    }
    
    func setupAvailableOptionsLabel() {
        availableOptionsLabel.text = "available_options".localized
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
    
    func changeMainViewSize(withType: OpportunitiesView) {

        switch withType {
        case .course:
            print("course")
            heightOfCourseView.constant = 120
            contentCourseView.configureExtendedView()
        case .task:
            print("task")
            heightOfTaskView.constant = 120
            contentTaskView.configureExtendedView()
        case .study:
            print("study")
            heightOfStudiesView.constant = 120
            contentStudiesView.configureExtendedView()
            
        }
        
        isProfileSize.toggle()
    }
        
}
