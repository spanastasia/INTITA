//
//  UIPageControlStackView.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 03.12.2020.
//

import UIKit

class UIPageControlStackView: UIStackView {
    var numberOfPages: Int = 0 {
        didSet {
            insertSubviews(numberOfPages)
        }
    }
    
    private var currentPageNumber = 0    
    private var active: MyView {
        return mySubviews[currentPageNumber]
    }
    
    private var mySubviews: [MyView] {
        return (subviews as? [MyView]) ?? []
    }
    
    func transition(next: Int) {
        mySubviews[currentPageNumber].configureOtherView()
        mySubviews[next].configureCurrentView()
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
            let view = MyView(frame: .zero)
            addArrangedSubview(view)
            view.configureOtherView()
        }
        active.configureCurrentView()
    }
}

class MyView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2.0
    }
}

private extension MyView {
    func configureCurrentView() {
        self.backgroundColor = UIColor.primaryColor
    }
    
    func configureOtherView() {
        self.backgroundColor = UIColor.white
        self.bordered()
    }
}
