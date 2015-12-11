//
//  ViewController.swift
//  GENNIUS_Swift
//
//  Created by jamalping on 15/12/8.
//  Copyright © 2015年 cisc. All rights reserved.
//

import UIKit
import Alamofire
class MyView: UIView {
    var stringToInt:((str:String)->Int)?
    init(frame: CGRect, stringToInt:(str:String)->Int) {
        self.stringToInt = stringToInt
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UIViewController {

    var request:Request? {
        didSet {
            oldValue?.cancel()
            headers = nil
            body = nil
        }
    }
    var headers:[String: String]? = [:]
    var body: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        let cycleScrollView = CycleScrollView.init(frame: CGRectMake(0, 0, self.view.width, 120), animationTimerInterVal: 2) { (index) -> Void in
            print("当前点击了第\(index)个")
        }
        cycleScrollView.backgroundColor = UIColor.redColor()
        cycleScrollView.dataSource = ["1","2","3"]
        self.view.addSubview(cycleScrollView)
        print(cycleScrollView.dataSource)
        
        
        // ["osType":"IOS","cipherText":"pf6SqFCvtSLmnA70J8OCZlMn47flAjYOMPdoaCuo+2aOYUKHx7i5XVaVpkjBIIHH8xt+ogsZu9yxVtvQol054jWaEOPPK5aFv/bp3rji5rlNd0ifyY+HQ/Qd0bsH0mZiiTCCdr6CsFi9zMCphpQNio0E0Wbg6zZLUHQC83by41M="]
        // http://genius-test.china-invs.cn:28080/genius_api/m/ver/get_ver.m
        // http://genius-test.china-invs.cn:28080/genius_api/m/u/app_auto_login.m
//        request = Alamofire.request(Method.GET, "http://genius-test.china-invs.cn:28080/genius_api/m/ver/get_ver.m",encoding:.URL)
        request = Alamofire.request(.POST, "http://genius-test.china-invs.cn:28080/genius_api/m/u/app_auto_login.m", parameters: ["osType":"IOS","cipherText":"pf6SqFCvtSLmnA70J8OCZlMn47flAjYOMPdoaCuo+2aOYUKHx7i5XVaVpkjBIIHH8xt+ogsZu9yxVtvQol054jWaEOPPK5aFv/bp3rji5rlNd0ifyY+HQ/Qd0bsH0mZiiTCCdr6CsFi9zMCphpQNio0E0Wbg6zZLUHQC83by41M="],encoding:.JSON)
        request?.responseString(encoding: NSUTF8StringEncoding, completionHandler: { (Response) -> Void in
            print(Response)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// refresh
    func refresh() {
        guard let request = request  else {
            return
        }
        request.responseString { (response) -> Void in
            if let response = response.response {
                
            }
        }
        
    }

}

