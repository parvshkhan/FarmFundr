//
//  TabButton.swift
//  FarmFundr
//
//  Created by Anupriya on 29/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import Foundation
import UIKit

class TabButton: UIButton {
    
    @IBInspectable var selectedColor  : UIColor = #colorLiteral(red: 0.9994125962, green: 0.4018217623, blue: 0, alpha: 1)
    
    @IBInspectable  var color  : UIColor = #colorLiteral(red: 0.9994125962, green: 0.4018217623, blue: 0, alpha: 1)
    
//    @IBInspectable var  selectedImage : UIImage = #imageLiteral(resourceName: "car_img")
//
//    @IBInspectable var  deSelectedImage : UIImage = #imageLiteral(resourceName: "red_car_icon")
    
    //@IBOutlet weak var imgvIcon: UIImageView!
    
    @IBOutlet weak var viewBg: UIView?
    
    @IBOutlet weak var lbltitle: UILabel?
    
    @IBOutlet weak var viewContiner: UIView?
    
    override var isSelected: Bool {
        
        willSet {
            
        }
        
        /*
         
         case shake(repeatCount: Int)
         case pop(repeatCount: Int)
         case squash(repeatCount: Int)
         case flip(along: Axis)
         case morph(repeatCount: Int)
         case flash(repeatCount: Int)
         case wobble(repeatCount: Int)
         case swing(repeatCount: Int)
         public enum Axis: String {
         case x, y
         }
         
         */
        
        didSet {
            
            if isSelected {
                
               // imgvIcon.image = selectedImage
                
                lbltitle?.textColor = selectedColor
                viewContiner?.isHidden = false
                viewBg?.backgroundColor = AppColors.green.color
                
            } else {
                
             //   imgvIcon.image = deSelectedImage
                lbltitle?.textColor =  color
                viewContiner?.isHidden = true
                viewBg?.backgroundColor = AppColors.lightGray.color
                
            }
            
        }
    }
    
}



