//
//  UIViewController+Extension.swift
//  GENNIUS_Swift
//
//  Created by jamalping on 15/12/11.
//  Copyright © 2015年 cisc. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func customBackButtonItemWithTitle(title:String, imageName:String)->UIButton{
        let backButton = UIButton.init(type: UIButtonType.Custom)
        backButton.setImage(UIImage.init(named: imageName), forState: UIControlState.Normal)
        backButton.sizeToFit()
        backButton.addTarget(self, action: Selector(backAction()), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backButton)
        return backButton
    }
    
    private func backAction(){
        if self.navigationController?.presentingViewController != nil&&self.navigationController!.viewControllers.count<=1 {
            self.dismissViewControllerAnimated(true, completion: nil)
        }else {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    func addTapGestureRecognizerForEndEdit(){
        let tap = UITapGestureRecognizer.init(target: self, action: Selector(endEdit()))
        self.view.addGestureRecognizer(tap)
    }
    
    func endEdit(){
        self.view.endEditing(true)
    }
}