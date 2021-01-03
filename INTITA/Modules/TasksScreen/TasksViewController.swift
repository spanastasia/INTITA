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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        let backBarButtonItem = UIBarButtonItem(title: "⟨", style: .plain, target: self, action: #selector(backButtonPressed))
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        //        self.navigationController?.navigationBar.backItem?.title = " "
        //        self.navigationController?.navigationBar.backItem?.backBarButtonItem = backBarButtonItem
        let headerCell = UINib(nibName: "TaskHeaderCell", bundle: nil)
        tasksHeadersCollectionView.register(headerCell, forCellWithReuseIdentifier: "HeaderReuseIdentifier")
        //for tableview
        //        let taskCell = UINib(nibName: "TaskCell", bundle: nil)
        //        taskTableView.register(taskCell, forCellWithReuseIdentifier: "reuseForTask")
        
    }
    @objc func backButtonPressed(){
        coordinator?.showProfileScreen()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfStates
    }
    //for tableview
    //        guard let state = State(rawValue: section) else { return 0 }
    //        return viewModel.getCountOfTasks(in: state)
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let state = State(rawValue: indexPath.row),
              let sectionHeader = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderReuseIdentifier", for: indexPath) as? TaskHeaderCell else { return UICollectionViewCell() }
        
        sectionHeader.titleOfTasks.text = viewModel.getTitle(for: state)
        return sectionHeader
    }
    //    for tableview
    //    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseForTask", for: indexPath) as? TaskCell else { return UICollectionViewCell() }
    //    guard let state = State(rawValue: indexPath.section) else { return UICollectionViewCell() }
    //
    //    cell.configure(with: viewModel.getTasks(for: state)[indexPath.row])
    //    return cell
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = collectionView.frame.width
        return CGSize(width: widthCell, height: collectionView.frame.height)
    }
    var isScrolling = false
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isScrolling else {
            return
        }
        let pageWidth = scrollView.bounds.width
        let pageFraction = scrollView.contentOffset.x/pageWidth
        
        let newPageNumber = Int((round(pageFraction)))
        print(">>> \(Date()) \(newPageNumber)")
        tasksHeadersCollectionView.scrollToItem(
            at: IndexPath(row: newPageNumber, section: 0),
            at: .centeredHorizontally,
            animated: true)
        isScrolling = true
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        isScrolling = false
    }
}
