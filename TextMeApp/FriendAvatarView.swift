//
//  FriendAvatarView.swift
//  TextMeApp
//
//  Created by jane on 06.04.2022.
//

import UIKit

@IBDesignable
class FriendAvatarView: UIView {
    
    //ручная настройка (по заданию)
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

       @IBInspectable
       var shadowOpacity: Float {
           get {
               return layer.opacity
           }
           set {
               layer.opacity = newValue
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
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        
       
        let borderView = self.subviews[0]
        borderView.frame = self.bounds
        borderView.layer.cornerRadius = 25
        borderView.layer.borderColor = UIColor.black.cgColor
        borderView.layer.masksToBounds = true
        borderView.addSubview(subviews[1])
        self.addSubview(borderView)
    }
}

