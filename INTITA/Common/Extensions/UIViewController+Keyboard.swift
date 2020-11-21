//
//  UIViewController+Keyboard.swift
//  INTITA
//
//  Created by  Oleksii Kolomiiets on 21.11.2020.
//

import Foundation

extension UIViewController {
    func startMonitoringKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidAppear),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidDissapear),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func stopMonitoringKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardDidAppear(notification: NSNotification) {
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        animateKeyboardAppearance(height: keyboardHeight)
    }
    
    @objc private func keyboardDidDissapear(notification: NSNotification) {
        animateKeyboardAppearance(height: 0)
    }
    
    @objc func animateKeyboardAppearance(height: CGFloat) {
        // override it
    }
}
