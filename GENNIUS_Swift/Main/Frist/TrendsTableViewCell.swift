//
//  TrendsTableViewCell.swift
//  GENNIUS_Swift
//
//  Created by jamalping on 15/12/12.
//  Copyright © 2015年 cisc. All rights reserved.
//

import Foundation
import UIKit

class TrendsTableViewCell:UITableViewCell {
    
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var headerView: UIImageView!
    
    var trendModel:TrendsModel?{
        didSet{
            nickNameLabel.text = trendModel?.stockName
        }
    }
    
    override func awakeFromNib() {
//        nickNameLabel.text = "111"
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}