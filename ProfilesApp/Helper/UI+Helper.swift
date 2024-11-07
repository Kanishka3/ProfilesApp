//
//  UI+Helper.swift
//  ProfilesApp
//
//  Created by Kanishka Chaudhry on 07/11/24.
//

import UIKit

extension UIButton {
    func setStandardStyle() {
        setTitle(GlobalConstants.buttonCta, for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 20)
        backgroundColor = .customYellow
        layer.cornerRadius = 16
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) //TODO: Use button config
    }
}

extension UITextField {
    func setStandardUI() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        keyboardType = .phonePad
        font = .boldSystemFont(ofSize: 20)
        layer.cornerRadius = 12
        textAlignment = .center
    }
}


extension UIColor {
    static let customYellow = UIColor(red: 0.98, green: 0.8, blue: 0.06, alpha: 1)
}

extension UIImageView {
    func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
