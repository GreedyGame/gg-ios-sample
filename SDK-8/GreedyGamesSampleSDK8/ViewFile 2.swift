//
//  ViewFile.swift
//  FamilyG
//
//  Created by APPLE on 28/02/18.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    
    // MARK:- Gradient
    /// This struct is used to set the Color Gradient (top and bottom) for  Gradient layer.We use this approach, because in extension we can't be able to create store property.
    struct SetColorForGradient {
        static var topColor = UIColor.white
        static var bottomColor = UIColor.white
    }
    
    @IBInspectable
    var gradientTopColor: UIColor? {
        get{
           return SetColorForGradient.topColor
        }
        set{
            if let color = newValue {
                SetColorForGradient.topColor = color
            }
        }
    }
    
    @IBInspectable
    var gradientBottomColor: UIColor? {
        get{
           return SetColorForGradient.bottomColor
        }
        set{
            if let color = newValue {
                SetColorForGradient.bottomColor = color
            }
        }
    }
    
    @IBInspectable
    var gradientlayer: Bool {
        get{
            if self.gradientlayer{
                let glayer = setGradient()
                if let topLayer = self.layer.sublayers?.first, topLayer is CAGradientLayer
                {
                    topLayer.removeFromSuperlayer()
                }
//                self.layer.addSublayer(glayer)
                self.layer.insertSublayer(glayer, at: 0)
                layer.cornerRadius = cornerRadius
                return true
            }else{
               return false
            }
        }
        set{
            if newValue{
                let glayer = setGradient()
                if let topLayer = self.layer.sublayers?.first, topLayer is CAGradientLayer
                {
                    topLayer.removeFromSuperlayer()
                }
//                self.layer.addSublayer(glayer)
                self.layer.insertSublayer(glayer, at: 0)
                glayer.cornerRadius = layer.cornerRadius
            }
        }
    }
    
    func setGradient() -> CAGradientLayer {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [gradientTopColor?.cgColor ?? UIColor.clear.cgColor, gradientBottomColor?.cgColor ?? UIColor.clear.cgColor]
//        gradientLayer.locations = [0.0,0.9]
        gradientLayer.type = .axial
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = self.bounds
        gradientLayer.masksToBounds = true
        
        return gradientLayer
    }
}

extension UIView{
    /// This is use to set the view without padding
    ///
    /// - Parameters:
    ///   - top: top anchor of the view
    ///   - bottom: bottom anchor of the view
    ///   - leading: leading anchor of the view
    ///   - trailing: trailing anchor of the view
    func anchor(top:NSLayoutYAxisAnchor, bottom:NSLayoutYAxisAnchor, leading:NSLayoutXAxisAnchor, trailing:NSLayoutXAxisAnchor){
        //To enable Auto Layout
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: top).isActive = true
        bottomAnchor.constraint(equalTo: bottom).isActive = true
        leadingAnchor.constraint(equalTo: leading).isActive = true
        trailingAnchor.constraint(equalTo: trailing).isActive = true
    }
    
    
    /// This is used to set the view with some padding
    ///
    /// - Parameters:
    ///   - top: top anchor of the view
    ///   - bottom: bottom anchor view
    ///   - leading: leading anchor view
    ///   - trailing: trailing anchor view
    ///   - padding: this is used to set the padding of the view can be set by using edgeinsets and its default value is zero
    
    ///   - NOTE: the bottom and trailing paaing should be a negative value
    func anchorWithPadding(top:NSLayoutYAxisAnchor, bottom:NSLayoutYAxisAnchor, leading:NSLayoutXAxisAnchor, trailing:NSLayoutXAxisAnchor, padding: UIEdgeInsets = .zero){
        
        // To enable Auto Layout
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
    }
    
    
    
    /// This is use to make the view with padding and fixed size and optional constraints
    ///
    /// - Parameters:
    ///   - top: top anchor of the view
    ///   - bottom: bottom anchor of the view
    ///   - leading: leading anchor of the view
    ///   - trailing: trailing anchor of the view
    ///   - padding: this is used to set the padding of the view can be set by using edgeinsets and its default value is zero
    ///   - size: size of the view (fixed width and height)
    func anchorWithPaddingAndSize(top:NSLayoutYAxisAnchor?, bottom:NSLayoutYAxisAnchor?, leading:NSLayoutXAxisAnchor?, trailing:NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize){
        
        // To enable Auto Layout
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let leading = leading{
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let trailing = trailing{
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0{
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0{
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    
    /** This is use to fill the entire superview(meand in which the view(subView) is added into the another View(SuperView)**/
    func fillSuperView() {
        if let superview = superview{
            anchor(top: superview.topAnchor, bottom: superview.bottomAnchor, leading: superview.leadingAnchor, trailing: superview.trailingAnchor)
        }
    }
    
    /// This method is used to set the corner radius to the particular corners cornerRadius property will set the all the corner.Instead we can use this to set for particular end
    /// - Parameters:
    ///   - corners: to set the corner radius to particular ends [like topLeft, topRight, bottomLeft and bottomRight]
    ///   - radius: corner radius value
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}





