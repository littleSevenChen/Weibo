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
    var verifited_Image: UIImage? {
        
        switch model?.user?.verified_level ?? -1{
            
        case -1:return nil
        case 0: return UIImage(named: "avatar_vip")
        case 2,3,5 : return UIImage(named: "avatar_enterprise_vip")
        case 220: return UIImage(named: "avatar_grassroot")
        default: return nil
            
        }
        
    }
    
    
    //会员等级 1-6
    var vipLevel_Imaeg: UIImage? {
        
        return UIImage(named: "common_icon_membership_level\(model?.user?.mbrank ?? 0)")
        
    }
    init(statusModel: SinaStatusModel) {
        super.init()
        self.model = statusModel
    }
}
