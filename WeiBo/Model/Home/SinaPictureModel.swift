//
//  SinaPictureModel.swift
//  WeiBo
//
//  Created by Chen on 2019/4/28.
//  Copyright © 2019 Chen. All rights reserved.
//


import UIKit

class SinaPictureModel: NSObject {
    
    //
  @objc  var thumbnail_pic: String?
    
    
    init(dic: [String: AnyObject]) {
        
        super.init()
        
        //一定要调用
        setValuesForKeys(dic)
        
    }
    
    // 防止崩溃
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    //
    override var description: String {
        
        let keys = ["thumbnail_pic"]
        return dictionaryWithValues(forKeys: keys).description
        
        
    }
}

