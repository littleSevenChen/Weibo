//
//  SinaConstant.swift
//  WeiBo
//
//  Created by Apple on 15/12/30.
//  Copyright © 2015年 itcast. All rights reserved.
//

import Foundation


/// 输出日志

/// - parameter message:  日志消息

/// - parameter logError: 错误标记，默认是 false，如果是 true，发布时仍然会输出

/// - parameter file:     文件名

/// - parameter method:   方法名

/// - parameter line:     代码行数

func printLog<T>(message: T,
    logError: Bool = false,
    file: String = #file,
    method: String = #function,
    line: Int = #line)
{
    if logError {
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    } else {
        #if DEBUG
            print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
        #endif
    }
}

// 
// 于 OC的 #define APP_Key    @"类似"


let redirect_Url = "http://www.baidu.com"
let app_Key = "740300893"
let app_Secret = "2c57263dd1ace2df39dde73f74a13b70"


//定义通知
let kNotificationEnter = "change"
// 定义一个 首页的间距
let SinaHomeMargin = 10
