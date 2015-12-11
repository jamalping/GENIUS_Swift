//
//  UIView+Extension.swift
//  JamalToolTest
//
//  Created by jamalping on 15/12/4.
//  Copyright © 2015年 cisc. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    var left:CGFloat {
        set (newValue) {
            self.frame.origin.x = newValue
        }
        get {
            return self.frame.origin.x
        }
    }
    
    var right:CGFloat {
        set (newValue) {
            self.frame.origin.x = newValue-self.frame.size.width
        }
        get {
            return self.frame.origin.x+self.frame.size.width
        }
    }
    var top:CGFloat {
        set (newValue) {
            self.frame.origin.y = newValue
        }
        get {
            return self.frame.origin.y
        }
    }
    
    var bottom:CGFloat {
        set (newValue) {
            self.frame.origin.y = newValue-self.frame.size.height
        }
        get {
            return self.frame.origin.y+self.frame.size.height
        }
    }
    var centerX:CGFloat {
        set (newValue) {
            self.center.x = newValue
        }
        get {
            return self.center.x
        }
    }
    var centerY:CGFloat {
        set (newValue) {
            self.center.y = newValue
        }
        get {
            return self.center.y
        }
    }
    var width:CGFloat {
        set (newValue) {
            self.frame.size.width = newValue
        }
        get {
            return self.frame.size.width
        }
    }
    var height:CGFloat {
        set (newValue) {
            self.frame.size.height = newValue
        }
        get {
            return self.frame.size.height
        }
    }
    var origin:CGPoint {
        set (newValue) {
            self.frame.origin = newValue
        }
        get {
            return self.frame.origin
        }
    }
    var size:CGSize {
        set (newValue) {
            self.frame.size = newValue
        }
        get {
            return self.frame.size
        }
    }
    
}

extension UIView {
    
    var viewController:UIViewController? {
        get {
            var view:UIView! = self
            while (view != nil){
                let nextResponder:UIResponder = view.nextResponder()!
                if nextResponder.isKindOfClass(UIViewController){
                    return nextResponder as? UIViewController
                }
                view = view.superview!
            }
            return nil;
        }
    }
    
    func resetOrientation() {
        let orientation:UIInterfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
        var transform:CGAffineTransform = CGAffineTransformIdentity
        switch (orientation) {
        case .LandscapeLeft:
            transform = CGAffineTransformRotate(transform, CGFloat.init(-M_PI/2));
            break;
        case .LandscapeRight:
            transform = CGAffineTransformRotate(transform, CGFloat.init(M_PI/2));
            break;
        case .PortraitUpsideDown:
            transform = CGAffineTransformRotate(transform, CGFloat.init(M_PI));
            break;
        default:
            break;
        }
        self.transform = transform;
    }
    
    func removeAllSubViews() {
        for view:UIView in self.subviews {
            view.removeFromSuperview()
        }
    }
}
