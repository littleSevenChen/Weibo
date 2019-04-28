//
//  SinaStatusModel.swift
//  WeiBo
//
//  Created by Chen on 2019/4/28.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit

class SinaStatusModel: NSObject {
    /// created_at    string    微博创建时间
 @objc   var created_at: String?
    ///id    int64    微博ID
  @objc  var id: Int = 0
    ///text    string    微博信息内容
   @objc var text: String?
    ///source    string    微博来源
   @objc var source: String?
    
   @objc var user: SinaUserModel?
    init(dic: [String: AnyObject]) {
        
        super.init()
        
        setValuesForKeys(dic)
        if let userDic = dic["user"] as? [String:AnyObject]{
            user = SinaUserModel(dic: userDic)
        }
        
    }
    
    //确保不崩溃
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
