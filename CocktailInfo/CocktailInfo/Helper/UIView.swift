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
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
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
    var shadowOpacity: Float {
        get { 0.0 }
        set { layer.shadowOpacity = newValue }
    }
    
}
