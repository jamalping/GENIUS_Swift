//
//  BaseNavigationViewController.swift
//  GENNIUS_Swift
//
//  Created by jamalping on 15/12/10.
//  Copyright © 2015年 cisc. All rights reserved.
//

import Foundation
import UIKit

class BaseNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
         super.viewDidLoad()
        self.navigationBar.translucent = false
        self.navigationBar.barTintColor = MainColor
        self.navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(16),NSForegroundColorAttributeName:UIColor.whiteColor()]
    }

    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        super.pushViewController(viewController, animated: animated)
    }
}
