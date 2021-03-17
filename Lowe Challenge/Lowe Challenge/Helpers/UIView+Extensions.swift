//
//  UIView+Extensions.swift
//  FinastraCodeChallenge
//
//  Created by Balaji Peddaiahgari on 3/13/21.
//

import Foundation
import UIKit

extension UIView {
    
    func pinView(to view: UIView) {
        let layoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            self.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            self.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            self.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
        ])
    }
    
    func center(in view: UIView) {
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func roundCorners(to radius: CGFloat = 8.0) {
        self.layer.cornerRadius = radius
    }
}
