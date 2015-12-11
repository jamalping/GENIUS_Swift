//
//  UIColor+Extension.swift
//  GENNIUS_Swift
//
//  Created by jamalping on 15/12/8.
//  Copyright © 2015年 cisc. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func randomColor()->UIColor {
//        let R:T = 0;
//        arc4random_buf(&R, Int(sizeof(R)))
        let R:CGFloat = CGFloat(arc4random_uniform(225))
        let G:CGFloat = CGFloat(arc4random_uniform(225))
        let B:CGFloat = CGFloat(arc4random_uniform(225))
        return UIColor(red: R/225.0, green: G/225.0, blue: B/225.0, alpha: 1)
    }
}