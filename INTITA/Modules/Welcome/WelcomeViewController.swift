//
//  WelcomeViewController.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 01.11.2020.
//

import UIKit

class WelcomeViewController: UIViewController, Storyboarded, UIScrollViewDelegate {
    @IBOutlet weak var mottoLabel: UILabel!
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var startBtn: UIButton!
    var coordinator: WelcomeCoordinator?
    @IBOutlet weak var line: UIView!
    
    @IBOutlet weak var skipBtn: UIButton!
    private var scrollView = UIScrollView(frame: .zero)
    private var stackView = UIStackView(frame: .zero)
    var views:[UIView] = []
    @IBOutlet weak var stackViewPageControl: UIPageControlStackView!
    
    let texts = ["promo1".localized,
                 "promo2".localized,
                 "promo3".localized,
                 "promo4".localized,
                 "promo5".localized,
                 "promo6".localized,
                 "promo7".localized,]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startBtn.layer.cornerRadius = 10.0
        startBtn.setTitle("start".localized, for: .normal)
        startBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        startBtn.titleLabel?.textAlignment = .center
        startBtn.titleLabel?.font = UIFont.primaryFontRegular
        startBtn.titleLabel?.layer.shadowColor = UIColor.black.cgColor
        startBtn.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 4)
        startBtn.titleLabel?.layer.shadowOpacity = 0.5
        startBtn.titleLabel?.layer.shadowRadius = 4.0
        
        mottoLabel.text = "motto".localized
        mottoLabel.textAlignment = .center
        mottoLabel.adjustsFontSizeToFitWidth = true
        mottoLabel.font = UIFont.primaryFontRegular
        mottoLabel.layer.shadowColor = UIColor.black.cgColor
        mottoLabel.layer.shadowOpacity = 0.5
        mottoLabel.layer.shadowOffset = CGSize(width: 0, height: 4)
        mottoLabel.layer.shadowRadius = 4.0
        
        skipBtn.setTitle("skip".localized, for: .normal)
        skipBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        skipBtn.titleLabel?.font = UIFont.primaryFontThin
        skipBtn.titleLabel?.textAlignment = .left
        
        logo.layer.cornerRadius = 10.0
        setupPageControll()
        setupScrollView()
        setupStackView(scrollView: scrollView)
        views = createAndAddViews(to: stackView)
    }
    
    @IBAction func goToLogInBtn(_ sender: UIButton) {
        coordinator?.displayLogin()
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
    
    func setupPageControll() {
        stackViewPageControl.numberOfPages = texts.count
        stackViewPageControl.currentPageImage = UIImage(named: "pageControlCurrentPage")
        stackViewPageControl.otherPagesImage = UIImage(named: "pageControlOtherPage")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let pageFraction = scrollView.contentOffset.x/pageWidth
        let constantFraction = pageFraction
        
        stackViewPageControl.transition(next: Int((round(pageFraction))))
        
        for (index, view) in views.enumerated() {
            guard let view = view as? PromoTextView else { return }
            let constant = pageWidth * (CGFloat(index) - constantFraction)
            view.updateViewCenterXAnchor(with: constant)
        }
    }
}




