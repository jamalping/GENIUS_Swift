//
//  TabbarController.swift
//  GENNIUS_Swift
//
//  Created by jamalping on 15/12/8.
//  Copyright © 2015年 cisc. All rights reserved.
//

//import Foundation
import UIKit

class TabbarController:UITabBarController {
    override func viewDidLoad() {
        self.tabbarViewControllers()
    }
    func tabbarViewControllers() {
        let VC1:ViewController = ViewController()
        let VC2:SecondViewController = SecondViewController()
        let VC3:ThreeViewController = ThreeViewController()
        let VC4:ForthViewController = ForthViewController()
        let VC5:FiveViewController = FiveViewController()
        
        let VCs:[UIViewController] = [VC1,VC2,VC3,VC4,VC5];
        var Navigations = [BaseNavigationViewController]()
        let titles:[String] = ["动态","社区","大赛","我","Five"];
        let normalImages:[String] = ["star","square-gray","community-","tab_activity","me"]
        let selectedImages:[String] = ["star_choosed","square-red","community-choose","tab_activity_red","me-choose"];
        for var i:Int = 0;i < VCs.count;i++ {
            let vc:UIViewController = VCs[i]
            let baseNavgVC:BaseNavigationViewController =  BaseNavigationViewController.init(rootViewController:vc)
            Navigations.append(baseNavgVC)
            
            vc.title = titles[i]
            vc.view.backgroundColor = UIColor.randomColor()
            vc.tabBarItem.title = titles[i]
            vc.tabBarItem.image = UIImage.init(named: normalImages[i])
            vc.tabBarItem.selectedImage = UIImage.init(named: selectedImages[i])
            vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -5)
            self.tabBar.tintColor = MainColor
        }
        self.viewControllers = Navigations as [UIViewController]
    }
}