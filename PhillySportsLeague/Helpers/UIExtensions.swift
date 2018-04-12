//
//  UIExtensions.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 4/7/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import Foundation
import UIKit


extension UITextField
{
    func underline()
    {
        let border = CALayer()
        let width = CGFloat(2.0)
        
        border.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}
