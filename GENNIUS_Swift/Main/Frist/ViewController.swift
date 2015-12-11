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

class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {

    let cellIdent = "cccc"
    var request:Request? {
        didSet {
            oldValue?.cancel()
            headers = nil
            body = nil
        }
    }
    var headers:[String: String]? = [:]
    var body: String?
    var tableView:UITableView?
    
    var dataSource:[AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.dataSource = ["1","1","1","1","1","1","1"]
        
        self.initSubViews()
        
        
        // ["osType":"IOS","cipherText":"pf6SqFCvtSLmnA70J8OCZlMn47flAjYOMPdoaCuo+2aOYUKHx7i5XVaVpkjBIIHH8xt+ogsZu9yxVtvQol054jWaEOPPK5aFv/bp3rji5rlNd0ifyY+HQ/Qd0bsH0mZiiTCCdr6CsFi9zMCphpQNio0E0Wbg6zZLUHQC83by41M="]
        // http://genius-test.china-invs.cn:28080/genius_api/m/ver/get_ver.m
        // http://genius-test.china-invs.cn:28080/genius_api/m/u/app_auto_login.m
//        request = Alamofire.request(Method.GET, "http://genius-test.china-invs.cn:28080/genius_api/m/ver/get_ver.m",encoding:.URL)
        request = Alamofire.request(.POST, "http://genius-test.china-invs.cn:28080/genius_api/m/u/app_auto_login.m", parameters: ["osType":"IOS","cipherText":"pf6SqFCvtSLmnA70J8OCZlMn47flAjYOMPdoaCuo+2aOYUKHx7i5XVaVpkjBIIHH8xt+ogsZu9yxVtvQol054jWaEOPPK5aFv/bp3rji5rlNd0ifyY+HQ/Qd0bsH0mZiiTCCdr6CsFi9zMCphpQNio0E0Wbg6zZLUHQC83by41M="],encoding:.JSON)
        request?.responseString(encoding: NSUTF8StringEncoding, completionHandler: { (Response) -> Void in
            print(Response)
        })
    }

    private func initSubViews() {
        let cycleScrollView = CycleScrollView.init(frame: CGRectMake(0, 0, self.view.width, 120), animationTimerInterVal: 2) { (index) -> Void in
            print("当前点击了第\(index)个")
        }
        cycleScrollView.backgroundColor = UIColor.redColor()
        cycleScrollView.dataSource = ["1","2","3"]
        self.view.addSubview(cycleScrollView)
        
        self.tableView = UITableView.init(frame: CGRectMake(0, cycleScrollView.bottom, self.view.width, self.view.height-cycleScrollView.bottom-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT), style: UITableViewStyle.Plain)
        self.tableView!.backgroundColor = UIColor.yellowColor()
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdent)
        self.view.addSubview(self.tableView!)
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

// MARK: - UITableView delegate and dataSource
extension ViewController {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.dataSource!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell =  tableView.dequeueReusableCellWithIdentifier(cellIdent)!
        cell.textLabel?.text = String(indexPath.row)
        return cell;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

}

