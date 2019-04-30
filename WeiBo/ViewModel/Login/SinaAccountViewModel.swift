//
//  SinaAccountViewModel.swift
//  WeiBo
//
//  Created by Chen on 2019/4/26.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit
import AFNetworking
class SinaAccountViewModel: NSObject {
 
    var model: SinaAccountModel?
   static let shareInstance = SinaAccountViewModel()
    var isLogin : Bool {
        
        return (SinaAccountViewModel.shareInstance.access_token == "") ? false : true
    }
    var access_token: String {
       return model?.access_token ?? ""
    }
    
    override init() {
        model = SinaAccountModel.readInfo()
    }
    //MARK：获取网络请求来获取token
     func getToken(code:String,success: @escaping ()->(),falure:@escaping (_ error:NSError)->()){
        let afn = AFHTTPSessionManager()
        afn.responseSerializer.acceptableContentTypes?.insert("text/plain")
        let params = [ "client_id": app_Key,
                       "client_secret":app_Secret,
                       "grant_type":"authorization_code",
                       "code":code,
                       "redirect_uri":redirect_Url
            
        ]
        afn.post("https://api.weibo.com/oauth2/access_token", parameters: params, success: { (_ , JSON) -> Void in
            
            //            print("=====\(JSON ?? nil)")
            let dic = JSON as? [String:AnyObject]
            if let dict = dic{
                let account = SinaAccountModel(dict: dict)
                self.personalInfo(accountModel: account, success: success, failure: falure)
                print(account)
            }
            
            /*
             "access_token" = "2.00cYTHKG0gkcu5a8f698925cEIKSwB";
             "expires_in" = 157679999;
             "remind_in" = 157679999;
             uid = 5646342270;
             */
            
        }) { (_ , error) -> Void in
            print(error)
        }
    }
    //MARK  获得token后，获取个人信息
    private func personalInfo(accountModel:SinaAccountModel,success:@escaping ()->(),failure:(_ errot:NSError)->()){
        if accountModel.access_token == nil || accountModel.uid == nil {
            fatalError("access_token或者uid为nil")
        }
        let afn = AFHTTPSessionManager()
        let  params = ["access_token": accountModel.access_token!,
                       "uid":accountModel.uid!]
        afn.get("https://api.weibo.com/2/users/show.json", parameters: params, progress: nil, success: { (_, JSON) in
            if let dic = JSON as? [String:AnyObject]{
                accountModel.screen_name = dic["screen_name"] as? String
                accountModel.profile_image_url = dic["profile_image_url"] as? String
                accountModel.saveInfo()
                success()
            }
            
        }) { (_, error) in
            print(error.localizedDescription)
            print(error)
        }
        
    }
    
}
