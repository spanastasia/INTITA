//
//  TasksViewController.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 25.12.2020.
//

import UIKit

class TasksViewController: UIViewController, Storyboarded, AlertAcceptable, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    @IBOutlet weak var tasksHeadersCollectionView: UICollectionView!
    
//    let tasksHeaders = ["Wait for task","In work", "Stopped", "Completed"]
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfStates
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let state = State(rawValue: section) else { return 0 }
        return viewModel.getCountOfTasks(in: state)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        guard let state = State(rawValue: indexPath.section) else { return UICollectionReusableView() }
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderReuseIdentifier", for: indexPath) as? TaskHeaderCell {
            sectionHeader.titleOfTasks.text = viewModel.getTitle(for: state)
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseForTask", for: indexPath) as? TaskCell else { return UICollectionViewCell() }
        guard let state = State(rawValue: indexPath.section) else { return UICollectionViewCell() }
        
        cell.configure(with: viewModel.getTasks(for: state)[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = collectionView.frame.width
        return CGSize(width: widthCell, height: collectionView.frame.height)
    }
//
     
    

    
    weak var coordinator: TasksCoordinator?
    var viewModel: TasksViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        let backBarButtonItem = UIBarButtonItem(title: "⟨", style: .plain, target: self, action: #selector(backButtonPressed))
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        
//        self.navigationController?.navigationBar.backItem?.title = " "
        
//        self.navigationController?.navigationBar.backItem?.backBarButtonItem = backBarButtonItem
        let headerCell = UINib(nibName: "TaskHeaderCell", bundle: nil)
        tasksHeadersCollectionView.register(headerCell, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderReuseIdentifier")
//        (headerCell, forCellWithReuseIdentifier: "HeaderReuseIdentifier")
        let taskCell = UINib(nibName: "TaskCell", bundle: nil)
        tasksHeadersCollectionView.register(taskCell, forCellWithReuseIdentifier: "reuseForTask")
//        tasksHeadersCollectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    @objc func backButtonPressed(){
        coordinator?.showProfileScreen()
    }
    
    
}
