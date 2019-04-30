//
//  SinaStatusViewModel.swift
//  WeiBo
//
//  Created by Chen on 2019/4/28.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit

class SinaStatusViewModel: NSObject {
    var model:SinaStatusModel?
    var profile_URL:NSURL?{
        // get方法
        return NSURL(string: model?.user?.profile_image_url ?? "")
    }
    ///reposts_count    int    转发数
    var reposts_string: String?{

        return model?.reposts_count == 0 ? "转发" : "转发:\(model?.reposts_count ?? 0)"
        
    }
    ///comments_count    int    评论数
    var comments_string: String? {
        return model?.comments_count == 0 ? "评论" : "评论:\(model?.comments_count ?? 0)"
    }
    ///attitudes_count    int    表态数
    var attitudes_string: String? {
        return model?.attitudes_count == 0 ? "赞" : "赞:\(model?.attitudes_count ?? 0)"
    }
    
    var verifited_Image: UIImage? {
        
        switch model?.user?.verified_level ?? -1{
            
        case -1:return nil
        case 0: return UIImage(named: "avatar_vip")
        case 2,3,5 : return UIImage(named: "avatar_enterprise_vip")
        case 220: return UIImage(named: "avatar_grassroot")
        default: return nil
            
        }
        
    }
    // 来源
    var source_string: String? {
        return getSource(str: model?.source ?? "")
        
    }
    
    //会员等级 1-6
    var vipLevel_Image: UIImage? {
        
        return UIImage(named: "common_icon_membership_level\(model?.user?.mbrank ?? 0)")
        
    }
    init(statusModel: SinaStatusModel) {
        super.init()
        self.model = statusModel
    }
    func getSource(str: String) -> String? {
        
        // 第一步,先确立正则
        let patter = "<a.*?\"(.*?)\">(.*)</a>"
        
        // 第二步,创建一个 regular expression
        /// 第一个参数--正则
        /// 第二个参数-- 关于正则里的设置说明 -- 让我们的 点 . 参与我们的正则
        let expression = try! NSRegularExpression(pattern: patter, options: NSRegularExpression.Options.dotMatchesLineSeparators)
        
        // 第三步, 通过字符串来查找我们的条件
        /// 第一个参数: 需要查找哪个字符串
        /// 第二个参数: 枚举,这个参数可以不用管,默认值
        /// 第三个参数: 范围
        
        /// 返回值 -- 如果都符合小括号里的值,会返回 小括号数量+1的个数, 这个 +1的个数是 他本身
        let result = expression.firstMatch(in: str, options: [], range: NSMakeRange(0, str.count))
      
        // 第四步,对结果进行筛选
        if result != nil {
            
            let range3 = result?.range(at: 2)
            
            //            print(range3)//(43,12)
            let source = (str as NSString).substring(with: range3!)
            
            
            return source
            
        }
        
        return ""
        
        
    }
}
