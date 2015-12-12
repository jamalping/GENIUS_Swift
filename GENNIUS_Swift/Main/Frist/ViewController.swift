//
//  ViewController.swift
//  GENNIUS_Swift
//
//  Created by jamalping on 15/12/8.
//  Copyright © 2015年 cisc. All rights reserved.
//

import UIKit
import Alamofire
import EVReflection

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

    let trendsTableViewCell = "TrendsTableViewCell"
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
        self.dataSource = []
        
        self.initSubViews()
        
        
        
        // ["osType":"IOS","cipherText":"pf6SqFCvtSLmnA70J8OCZlMn47flAjYOMPdoaCuo+2aOYUKHx7i5XVaVpkjBIIHH8xt+ogsZu9yxVtvQol054jWaEOPPK5aFv/bp3rji5rlNd0ifyY+HQ/Qd0bsH0mZiiTCCdr6CsFi9zMCphpQNio0E0Wbg6zZLUHQC83by41M="]
        // http://genius-test.china-invs.cn:28080/genius_api/m/ver/get_ver.m
        // http://genius-test.china-invs.cn:28080/genius_api/m/u/app_auto_login.m
//        request = Alamofire.request(Method.GET, "http://genius-test.china-invs.cn:28080/genius_api/m/ver/get_ver.m",encoding:.URL)
        
//        NSString *url = CSFormat(@"%@?opt=%ld&p=%ld",requestWithAction(GET_INT(kApi_get_GeniusNews)),geniusType,page);
        
//        NSString.localizedStringWithFormat(@"%@?opt=%ld&p=%ld", <#T##args: CVarArgType...##CVarArgType#>)
        let url = URLWithAPICode(kAPI_GENIUS_NEWS)+"?"+"opt="+"\(1)"+"&p="+"\(1)"
        Alamofire.request(.GET,url,encoding:.JSON)
        .responseString { (response) -> Void in
            print(response.result.value)
            var dic:Dictionary = EVReflection.dictionaryFromJson(response.result.value)
            
//            let data = dic["data"] as! Array
            if let data = dic["data"]{
                for var element:NSDictionary in data as! Array{
                    if let tt = element["serialList"]{
                        let trendModel = TrendsModel(dictionary: tt[0] as! NSDictionary)
                        self.dataSource?.append(trendModel)
                    }
                }
            }
            self.tableView!.reloadData()
//            let dic = response.result.value
//            let model = TrendsModel.init(fileNameInTemp: "sample_json")
        }
//            .responseString(completionHandler: { (response) -> Void in
//                print(EVReflection.dictionaryFromJson(response.result.value as? String))
//            })
//        .responseJSON { (response) -> Void in
//            print(EVReflection.dictionaryFromJson(response.result.value as? String))
//        }
//        EVReflection.dictionaryFromJson(<#T##json: String?##String?#>)
//            .responseObject { (response:Result<TrendsModel,NSError>) -> Void in
//                if let aaa = response.value {
//                    print(aaa.stockCode)
//                    
//                }
//        }
//        request?.responseString(encoding: NSUTF8StringEncoding, completionHandler: { (response) -> Void in
//            print(response.result.value)
//            TrendsModel(json: response.result.value)
//        })
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
        self.tableView!.registerNib(UINib.init(nibName: "TrendsTableViewCell", bundle: nil), forCellReuseIdentifier: trendsTableViewCell)
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
        let cell =  tableView.dequeueReusableCellWithIdentifier(trendsTableViewCell) as! TrendsTableViewCell
//        cell.textLabel?.text = String(indexPath.row)
//        cell.nickNameLabel.text = String(indexPath.row)
        cell.trendModel = self.dataSource![indexPath.row] as? TrendsModel
        return cell;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

}

