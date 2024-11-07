//
//  ToastManager.swift
//  ProfilesApp
//
//  Created by Kanishka Chaudhry on 08/11/24.
//

import UIKit
import UIKit

class ToastManager {
    
    static let shared = ToastManager()
    
    private var toastView: UIView?
    
    private init() {}
    
    func showToast(_ message: String) {
        let allScenes = UIApplication.shared.connectedScenes
        let scene = allScenes.first { $0.activationState == .foregroundActive }
        guard let windowScene = scene as? UIWindowScene, let window = windowScene.keyWindow else {
            return
        }
        
        // Avoid showing a new toast if one is already visible
        if toastView != nil {
            return
        }
        
        // Create a toast view
        let toastView = UIView()
        toastView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastView.layer.cornerRadius = 8
        toastView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = message
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        
        toastView.addSubview(label)
        window.addSubview(toastView) // Add the toast view to the window
        
        // Constraints for the toast view
        toastView.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 16).isActive = true
        toastView.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -16).isActive = true
        toastView.topAnchor.constraint(equalTo: window.topAnchor, constant: 80).isActive = true
        
        // Label Constraints
        label.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 16).isActive = true
        label.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -16).isActive = true
        label.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 8).isActive = true
        label.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -8).isActive = true
        
        // Store the reference to the toast view
        self.toastView = toastView
        
        // Animate the toast view into view
        toastView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            toastView.alpha = 1
        }
        
        // Dismiss the toast after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.hideToast()
        }
    }
    
    // Function to hide the toast
    private func hideToast() {
        guard let toastView = self.toastView else {
            return
        }
        
        // Animate the toast view out of view
        UIView.animate(withDuration: 0.3, animations: {
            toastView.alpha = 0
        }) { _ in
            toastView.removeFromSuperview()
            self.toastView = nil
        }
    }
}
