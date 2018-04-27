//
//  UIHelpers.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 4/19/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import Foundation
import UIKit

func alertBox(_ title: String, message: String, controller: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    controller.present(alert, animated: true, completion: nil)
}


func BoldPartOfString(_ prefix: String, label: String) -> NSMutableAttributedString {
    let attrs = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 17)]
    let attributedString = NSMutableAttributedString(string: prefix, attributes:attrs)
    let normalString = NSMutableAttributedString(string:" " + label)
    attributedString.append(normalString)
    return attributedString
}
