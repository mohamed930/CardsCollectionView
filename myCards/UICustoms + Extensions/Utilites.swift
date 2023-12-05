

//  UIView+Extentions.swift
//  GoalsList
//
//  Created by Develop on 11/6/21.
//  Copyright © 2021 Develop. All rights reserved.
//

import UIKit


extension UIView {
    //MARK:- Create cornerReduis , border and color with @IBInspectable
    
    @IBInspectable var cornerRaduis : CGFloat {
        get {
            return self.cornerRaduis
        }
        set {
            return self.layer.cornerRadius = newValue
        }
        
    }
    @IBInspectable var border : CGFloat  {
        get {
            return self.border
        }
        set {
            return  self.layer.borderWidth = newValue
        }
        
    }
    
    @IBInspectable var borderColor : UIColor? {
        get{
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else{
                return layer.borderColor = nil
            }
            
        }
        
    }
    @IBInspectable var Shadow : CGFloat  {
        get {
            return self.Shadow
        }
        set {
            return  self.layer.shadowRadius = newValue
        }
        
    }
    @IBInspectable var shadowColor : UIColor? {
           get{
               if let color = layer.shadowColor {
                   return UIColor(cgColor: color)
               }
               return nil
           }
           set {
               if let color = newValue {
                   layer.shadowColor = color.cgColor
               } else{
                   return layer.shadowColor = nil
               }
               
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
    
    
    
    //MARK:- Functions to Create line under TextField and change placeholder color.
    
    public  func createLineUnderView(width:CGFloat){
        let line  = CALayer()
        line.frame = CGRect(x:0, y: self.bounds.height - 5 , width:self.bounds.width, height: 1)
              line.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
              self.layer.addSublayer(line)
        // padding from X , Y dimensions .
        
        line.bounds = line.frame.insetBy(dx: width, dy: 0)    }
    
    
    // to change placeholder color
    func customTextField(textfeild:UITextField,placeholder:String,_ placeholdercolor:UIColor) {
        let line  = CALayer()
        line.frame = CGRect(x:0, y: self.bounds.height + 4  , width:self.frame.width  , height: 1)
        line.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
              self.layer.addSublayer(line)
        
        textfeild.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : placeholdercolor])
    }
    
}

