//
//  SinaUserModel.swift
//  WeiBo
//
//  Created by Chen on 2019/4/28.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit

class SinaUserModel: NSObject {
    /// id    int64    用户UID
 @objc   var id: Int = 0
    ///  screen_name    string    用户昵称
  @objc   var screen_name: String?
    ///profile_image_url    string    用户头像地址（中图），50×50像素
  @objc   var profile_image_url: String?
    
    /// 用户认证图像
    /// 认证类型 -1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
   @objc  var verified_level: Int = 0
    /// 会员等级 1-6
   @objc  var mbrank: Int = 0
    init(dic:[String:AnyObject]){
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
