//
//  UIPageControlStackView.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 05.11.2020.
//

import UIKit


@IBDesignable class UIPageControlStackView: UIStackView { // emulates UIPageControl behaviour
    @IBInspectable var currentPageImage: UIImage?
    @IBInspectable var otherPagesImage: UIImage?
    @IBInspectable var numberOfPages: Int = 0 {
        didSet {
            insertSubviews(numberOfPages)
        }
    }
    
    private lazy var active: UIImageView! = {
        return subviews.first as! UIImageView
    }()
    
    func transition(next: Int) { //The next active page control
        UIView.animate(withDuration: 0.5) {
            guard let currentDot = self.subviews[next] as? UIImageView else {return}
            currentDot.image = self.currentPageImage
            self.active.image = currentDot.image
            if next != 0 {
                guard let previousDot = self.subviews[next-1] as? UIImageView else {return}
                
                previousDot.image = self.otherPagesImage
            }
        }
        // here should be reverce scrolling pages
    }
    
    private func insertSubviews(_ n: Int) { //for the first fill
        subviews.forEach { view in
            view.removeFromSuperview()
        }
        axis = .horizontal
        distribution = .fillEqually
        spacing = 10
        for _ in Array(repeating: 0, count: n) {
            let view = UIImageView(frame: .zero)
            view.image = otherPagesImage
            addArrangedSubview(view)
        }
        active.image = currentPageImage
    }
}
