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
    ///reposts_count    int    转发数
   @objc var reposts_count: Int = 0
    ///comments_count    int    评论数
   @objc var comments_count: Int = 0
    ///attitudes_count    int    表态数
   @objc var attitudes_count: Int = 0
   @objc var retweeted_status: SinaStatusModel?
    
    //配图的模型
   @objc var pic_urls: [SinaPictureModel]?
   
    init(dic: [String: AnyObject]) {
        
        super.init()
        
        setValuesForKeys(dic)
        if let userDic = dic["user"] as? [String:AnyObject]{
            user = SinaUserModel(dic: userDic)
        }
        // 读取转发微博的信息
        if let retweetDic = dic["retweeted_status"] as? [String: AnyObject] {
            
            retweeted_status = SinaStatusModel(dic: retweetDic)
            
        }
        
        //
        if let pics = dic["pic_urls"] as? [[String:AnyObject]] {
            
            
            // 给数组初始化
            pic_urls = [SinaPictureModel]()
            // 进行遍历
            for pic in pics {
                
                let picModel = SinaPictureModel(dic: pic)
                
                //添加到数组里
                pic_urls?.append(picModel)
                
            }
            
        }
    }
    
    //确保不崩溃
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
