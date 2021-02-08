//
//  UIView.swift
//  CocktailInfo
//
//  Created by Fábio Maciel de Sousa on 06/02/21.
//

import UIKit

extension UIView {
    private var deviceHeight: CGFloat { UIScreen.main.bounds.height }
    private var originalHeight: CGFloat { 896.0 }
    
    /// Adapts constraints to resize according to device's height. It does it recursively meaning all children views will also be affected.
    func setHeightRelativeToDevice() {
        self.constraints
            .filter { $0.identifier == "dynamic" }
            .forEach { $0.constant = ($0.constant * deviceHeight) / originalHeight }
        self.subviews
            .forEach { $0.setHeightRelativeToDevice() }
    }
    
    /// Rounds the view.
    func setRoundedShadow() {
        layer.cornerRadius = frame.height/2
    }
}
