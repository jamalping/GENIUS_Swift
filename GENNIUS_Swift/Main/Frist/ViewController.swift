//
//  ViewController.swift
//  GENNIUS_Swift
//
//  Created by jamalping on 15/12/8.
//  Copyright © 2015年 cisc. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {

    let trendsTableViewCell = "TrendsTableViewCell"

    var vcPresenter:Presenter?
    
    var tableView:UITableView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.vcPresenter = Presenter()
        self.vcPresenter?.require.successe = {[unowned self] ()->() in
            return self.tableView!.reloadData()
        }
        self.initSubViews()
        
        self.vcPresenter!.requiredDareWithPage(self.vcPresenter!.currentPage)
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
}

// MARK: - UITableView delegate and dataSource
extension ViewController {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.vcPresenter!.dataSource!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCellWithIdentifier(trendsTableViewCell) as! TrendsTableViewCell
        cell.trendModel = self.vcPresenter!.dataSource![indexPath.row] as? TrendsModel
//        cell.nickNameLabel.text = self.vcPresenter!.dataSource![indexPath.row] as? String
        return cell;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

}

