//
//  UIPageControlStackView.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 05.11.2020.
//

import UIKit

// emulates UIPageControl behaviour
class UIPageControlStackView: UIStackView {
    @IBInspectable var currentPageImage: UIImage?
    @IBInspectable var otherPagesImage: UIImage?
    @IBInspectable var numberOfPages: Int = 0 {
        didSet {
            insertSubviews(numberOfPages)
        }
    }
    
    private var currentPageNumber = 0    
    private var active: UIImageView? {
        return subviews[currentPageNumber] as? UIImageView
    }
    
    func transition(next: Int) {
            guard let currentDot = subviews[next] as? UIImageView else {return}
            active?.image = otherPagesImage
            currentDot.image = currentPageImage
            currentPageNumber = next
    }
    
    private func insertSubviews(_ n: Int) {
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
        active?.image = currentPageImage
    }
}
