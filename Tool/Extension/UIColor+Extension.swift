//
//  UIColor+Extension.swift
//  Testeeee
//
//  Created by jamalping on 15/12/5.
//  Copyright © 2015年 jamalping. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func griadient(fromColor fromColor:UIColor,toColor:UIColor,height:CGFloat)->UIColor?{
        let size:CGSize = CGSizeMake(1, height)
        UIGraphicsBeginImageContext(size)
        let content:CGContextRef = UIGraphicsGetCurrentContext()!
        let colorSpace:CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!
        let colorRfs :[CGColorRef] = [fromColor.CGColor,toColor.CGColor]
        let gradient:CGGradientRef = CGGradientCreateWithColors(colorSpace, colorRfs, nil)!
        CGContextDrawLinearGradient(content, gradient, CGPointZero, CGPointMake(0, height), CGGradientDrawingOptions.DrawsBeforeStartLocation)
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return UIColor.init(patternImage: image)
    }
    
    class func randomColor()->UIColor?{
        let R:CGFloat = CGFloat(arc4random_uniform(255))
        let G:CGFloat = CGFloat(arc4random_uniform(255))
        let B:CGFloat = CGFloat(arc4random_uniform(255))
        return UIColor.init(red: R/255.0, green: G/255.0, blue: B/255.0, alpha:1.0);
    }
}