//
//  TrendsModel.swift
//  GENNIUS_Swift
//
//  Created by jamalping on 15/12/12.
//  Copyright © 2015年 cisc. All rights reserved.
//

import Foundation
import EVReflection

class TrendsModel: EVObject {
//    createDate;  //操作日期
//    @property (nonatomic,copy)NSString *createTime; //操作时间
//    @property (nonatomic,assign)long myId;         //晒单流水号
//    @property (nonatomic,assign)BOOL isSupport;
//    @property (nonatomic,assign)NSInteger supportCount; //当前被赞次数
//    @property (nonatomic,assign)NSInteger commentCount; //评论数
//    @property (nonatomic,copy)NSString *market; //A股市场类型 （深市-se:  沪市-sh:）
//    @property (nonatomic,copy)NSString *nickname;   //昵称
//    @property (nonatomic,copy)NSString *userIcon; //用户头像
//    @property (nonatomic,assign)CGFloat singleYield;    //单笔收益
//    @property (nonatomic,assign)CGFloat yield; //收益率（周收益）
//    @property (nonatomic,copy)NSString *stockCode;  //证券代码
//    @property (nonatomic,copy)NSString *stockName;  //证券名称
//    @property (nonatomic,copy)NSString *tradePosition;  //仓位
//    @property (nonatomic,copy)NSString *tradePrice; //成交价格
//    @property (nonatomic,copy)NSString *tradeType; //交易类型
//    @property (nonatomic,copy)NSString *tradeVol;
//    @property (nonatomic,copy)NSString *userId; //用户id
    var id:CLongLong?
    var isSupport:Bool? = false
    var supportCount:CLongLong?
    var market:String?  ///（深市-se:  沪市-sh:）
    var yield:String?
    var createDate:String?
    var userIcon:String?
    var tradeType:String?
    var tradePosition:String?
    var userId:String?
    var stockCode:String?
    var stockName:String?
    var tradeVol:String?
    var singleYield:String?
    var commentCount:String?
    var nickname:String?
    var tradePrice:String?
    var createTime:String?
}