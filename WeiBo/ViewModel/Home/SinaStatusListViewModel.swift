//
//  SinaStatusListViewModel.swift
//  WeiBo
//
//  Created by Chen on 2019/4/28.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit
import AFNetworking

class SinaStatusListViewModel: NSObject {
    lazy var list:[SinaStatusViewModel] = [SinaStatusViewModel]()
    
    func getData(success:@escaping ()->(),failure:()->()) -> () {
        let afn = AFHTTPSessionManager()
        let params = ["access_token":SinaAccountViewModel.shareInstance.access_token]
        afn.get("https://api.weibo.com/2/statuses/home_timeline.json", parameters: params, progress: nil, success: { (_, JSON) in
//            print("JSON = \(String(describing: JSON))")
            if let dic = JSON as? [String:AnyObject]{
                let statuses = dic["statuses"] as! [[String:AnyObject]]
                for status in statuses{
                    let statusModel = SinaStatusModel(dic: status)
                    
                    self.list.append(SinaStatusViewModel(statusModel: statusModel))
                }
                success()
            }
            
            
        }) { (_, error) in
            print(error)
           
        }
    }
}
