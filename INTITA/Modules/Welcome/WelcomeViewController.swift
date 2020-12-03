//
//  WelcomeViewController.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 01.11.2020.
//

import UIKit

class WelcomeViewController: UIViewController, Storyboarded, UIScrollViewDelegate {
    var coordinator: WelcomeCoordinator?
    
    @IBOutlet weak var mottoLabel: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var stackViewPageControl: UIPageControlStackView!
    
    private var scrollView = UIScrollView(frame: .zero)
    private var stackView = UIStackView(frame: .zero)
    var views:[UIView] = []
    
    let texts = ["promo1".localized,
                 "promo2".localized,
                 "promo3".localized,
                 "promo4".localized,
                 "promo5".localized,
                 "promo6".localized,
                 "promo7".localized,]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        
        setupMottoLabel()
        setupStartBtn()
        setupSkipBtn()
        logo.rounded()
        
        setupScrollView()
        setupStackView(scrollView: scrollView)
        views = createAndAddViews(to: stackView)
        
        stackViewPageControl.numberOfPages = texts.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func goToLogInBtn(_ sender: UIButton) {
        coordinator?.displayLogin()
        UserData.isFirstTimeUser = false
    }
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        self.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.line.bottomAnchor, constant: 32),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: self.stackViewPageControl.topAnchor, constant: -24)
        ])
    }
    
    func setupStackView(scrollView: UIScrollView) {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16)
        ])
    }
    
    func createAndAddViews(to stackView: UIStackView) -> [UIView] {
        var views:[UIView] = []
        texts.forEach { (text) in
            let pageView = PromoTextView(promoText: text)
            views.append(pageView)
        }
        
        views.forEach { (view) in
            view.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(view)
            view.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor).isActive = true
            view.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        }
        return views
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let pageFraction = scrollView.contentOffset.x/pageWidth
        
        stackViewPageControl.transition(next: Int((round(pageFraction))))
        
        for (index, view) in views.enumerated() {
            guard let view = view as? PromoTextView else { return }
            let constant = pageWidth * (CGFloat(index) - pageFraction)
            view.updateViewCenterXAnchor(with: constant)
        }
    }
    
    func setupStartBtn(){
        startBtn.setTitle("start".localized, for: .normal)
        startBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        startBtn.titleLabel?.textAlignment = .center
        startBtn.titleLabel?.font = UIFont.primaryFontRegular
        startBtn.titleLabel?.shadowed()
        startBtn.rounded()
    }
    func setupSkipBtn() {
        let skipStackView = UIStackView(frame: .zero)
        let imgView = UIImageView(frame: CGRect(x: 150, y: 0, width: 10, height: 24))
        imgView.image = UIImage(named:"skipArrow")!
        let skipLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 28))
        skipLabel.text = "skip".localized
        skipLabel.font = UIFont.primaryFontLight
        skipLabel.textAlignment = .right
        skipStackView.addSubview(skipLabel)
        skipStackView.addSubview(imgView)
        skipBtn.addSubview(skipStackView)
    }
    
    func setupMottoLabel() {
        mottoLabel.text = "motto".localized
        mottoLabel.textAlignment = .center
        mottoLabel.adjustsFontSizeToFitWidth = true
        mottoLabel.font = UIFont.primaryFontRegular
        mottoLabel.shadowed()
    }
}




