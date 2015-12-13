//
//  ViewModel.swift
//  GENNIUS_Swift
//
//  Created by jamalping on 15/12/13.
//  Copyright © 2015年 cisc. All rights reserved.
//

import Foundation
import Alamofire
import EVReflection

class Presenter {
    var dataSource:[AnyObject]? = []
    var pageCount:Int?
    var currentPage = 1
    var require = Require()
    struct Require {
        var successe:(()->())?
        var error:(()->())?
    }
    
    
    func requiredDareWithPage(page:Int) {
        let url = URLWithAPICode(kAPI_GENIUS_NEWS)+"?"+"opt="+"\(0)"+"&p="+"\(1)"
        Alamofire.request(.GET,url,encoding:.JSON)
            .responseString { (response) -> Void in
                print(response.result.value)
                var dic:Dictionary = EVReflection.dictionaryFromJson(response.result.value)
                if let data = dic["data"]{
                    for var element:NSDictionary in data as! Array{
                        if let tt = element["serialList"]{
                            let trendModel = TrendsModel(dictionary: tt[0] as! NSDictionary)
                            self.dataSource?.append(trendModel)
                        }
                    }
                }
                self.dataSource?.append("1")
                self.require.successe!()
        }
    }
}


