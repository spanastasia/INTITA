//
//  TasksViewController.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 25.12.2020.
//

import UIKit

class TasksViewController: UIViewController, Storyboarded, AlertAcceptable, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    var viewModel: TasksViewModel!
    weak var coordinator: TasksCoordinator?
    @IBOutlet weak var tasksHeadersCollectionView: UICollectionView!
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var priorities: UIButton!
    @IBOutlet weak var types: UIButton!
    @IBOutlet weak var groups: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonPressed))
                self.navigationController?.navigationBar.backItem?.backBarButtonItem = backBarButtonItem
        //TODO:  set title for controller
        let headerCell = UINib(nibName: "TaskHeaderCell", bundle: nil)
        tasksHeadersCollectionView.register(headerCell, forCellWithReuseIdentifier: "HeaderReuseIdentifier")
        let taskCell = UINib(nibName: "TaskCell", bundle: nil)
        taskTableView.register(taskCell, forCellReuseIdentifier: "reuseForTask")
        tasksHeadersCollectionView.bordered()
        tasksHeadersCollectionView.rounded()
        taskTableView.bordered()
        taskTableView.rounded()
        priorities.titleLabel?.font = UIFont.primaryFontLight
        priorities.setTitle("priorities".localized, for: .normal)
        types.titleLabel?.font = UIFont.primaryFontLight
        types.setTitle("type".localized, for: .normal)
        groups.titleLabel?.font = UIFont.primaryFontLight
        groups.setTitle("groups".localized, for: .normal)
    }
    @objc func backButtonPressed(){
        coordinator?.showProfileScreen()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfStates
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let state = State(rawValue: indexPath.row),
              let sectionHeader = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderReuseIdentifier", for: indexPath) as? TaskHeaderCell else { return UICollectionViewCell() }
        
        sectionHeader.configure(title: viewModel.getTitle(for: state), count: viewModel.getCountOfTasks(in: state))
        return sectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = collectionView.frame.width
        return CGSize(width: widthCell, height: collectionView.frame.height)
    }
   private var currentPage = 0
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let pageFraction = scrollView.contentOffset.x/pageWidth
        
        let newPageNumber = Int((round(pageFraction)))
        if newPageNumber != currentPage {
            currentPage = newPageNumber
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        taskTableView.reloadData()
    }
}

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let state = State(rawValue: currentPage) else {return 0}
        return viewModel.getCountOfTasks(in: state)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = taskTableView.dequeueReusableCell(withIdentifier: "reuseForTask", for: indexPath) as? TaskCell,
              let state = State(rawValue: currentPage) else { return UITableViewCell() }
        let tasks = viewModel.getTasks(for: state)
        guard tasks.count > indexPath.row else { return UITableViewCell() }
        
        cell.configure(with: tasks[indexPath.row])
        return cell
    }
}
