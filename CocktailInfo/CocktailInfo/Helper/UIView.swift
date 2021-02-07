//
//  UIView.swift
//  CocktailInfo
//
//  Created by Fábio Maciel de Sousa on 06/02/21.
//

import UIKit

@IBDesignable
extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get { 0.0 }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get { 0.0 }
        set {
            layer.masksToBounds = false
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get { .zero }
        set { layer.shadowOffset = newValue }
    }
    
    @IBInspectable
    var shadowColor: UIColor {
        get { #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) }
        set { layer.shadowColor = newValue.cgColor }
    }
    
    @IBInspectable
    var shadowOpacity: CGFloat {
        get { 0.0 }
        set { layer.shadowOpacity = Float(newValue) }
    }
    
}

extension UIView {
    private var deviceHeight: CGFloat { UIScreen.main.bounds.height }
    private var originalHeight: CGFloat { 896.0 }
    
    func setHeightRelativeToDevice() {
        self.constraints
            .filter { $0.identifier == "dynamic" }
            .forEach { $0.constant = ($0.constant * deviceHeight) / originalHeight }
        self.subviews
            .forEach { $0.setHeightRelativeToDevice() }
    }
    
    func setRoundedShadow() {
        layer.cornerRadius = frame.height/2
    }
}
