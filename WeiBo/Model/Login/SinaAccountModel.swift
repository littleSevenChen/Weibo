//
//  SinaAccountModel.swift
//  WeiBo
//
//  Created by Chen on 2019/4/26.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit

class SinaAccountModel: NSObject {
    //  access_token    string    用于调用access_token，接口获取授权后的access token。
   @objc var access_token: String?
    //expires_in    string    access_token的生命周期，单位是秒数。
    // 123456789
    @objc var expires_in: TimeInterval = 0{
        
        didSet{
            // 把一个秒数传递给 NSDate,然后就变成了一个 NSDate类型的变量
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
            
        }
        
    }
    //uid    string    当前授权用户的UID。
    @objc  var uid: String?
    // 怎么处理我们的时间-- 定义一个属性,来接受我们计算好的时间
    var expires_date: NSDate?
    
    /// screen_name    string    用户昵称
    var screen_name: String?
    /// profile_image_url    string    用户头像地址（中图），50×50像素
    var profile_image_url: String?
    
     init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.uid = aDecoder.decodeObject(forKey: "uid") as? String
        self.access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        self.expires_date = aDecoder.decodeObject(forKey: "expires_date") as? NSDate
        self.screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
        self.profile_image_url = aDecoder.decodeObject(forKey: "profile_image_url") as? String
        
    }
    // 归档 -- 把对象转变成 二进制保存在硬盘里
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encode(self.uid, forKey: "uid")
        aCoder.encode(self.access_token, forKey: "access_token")
        aCoder.encode(self.expires_date, forKey: "expires_date")
        aCoder.encode(self.screen_name, forKey: "screen_name")
        aCoder.encode(self.profile_image_url, forKey: "profile_image_url")
        
    }
    func saveInfo() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!+"/weibo.info"
        
        print("path = \(path)")
    }
}
