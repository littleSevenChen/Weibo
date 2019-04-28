//
//  SinaWelcomeViewController.swift
//  WeiBo
//
//  Created by Chen on 2019/4/28.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit
import SnapKit
class SinaWelcomeViewController: UIViewController {
var bottomSnapKitConstraint: Constraint?
    override func loadView() {
        
        view = UIImageView(image: UIImage(named: "ad_background"))
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 更新约束
        //        bottomConstraint?.constant = -(UIScreen.mainScreen().bounds.height - 150)
        
        bottomSnapKitConstraint?.updateOffset(amount: -(UIScreen.main.bounds.height - 150))
        // 第二个问题,动画效果
        // usingSpringWithDamping -- 范围为 0.0f 到 1.0f，数值越小 弹簧 的振动效果越明显
        // initialSpringVelocity :  则表示初始的速度，数值越大一开始移动越快，初始速度取值较高而时间较短时，会出现反弹情况
        // OC里枚举可以写 nil, Swift 可以用 []

        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            
        }) { (Bool)->Void in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotificationEnter), object: nil)
    
        }
    }
    func setupUI()  {
        view.addSubview(photoImageView)
        view.addSubview(nameLabel)
        
        photoImageView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp_centerX)
//            make.bottom.equalTo(view.snp_bottom).offset(-150)
             bottomSnapKitConstraint = make.bottom.equalTo(view.snp_bottom).offset(-150).constraint
        }
       //欢迎文字设置约束 -- 水平居中, 顶部等于photoImageView底部+ 一个距离
        nameLabel.snp_makeConstraints { (make)->Void in
            make.centerX.equalTo(view.snp_centerX)
            make.top.equalTo(photoImageView.snp_bottom).offset(10)
        }
    }
    
    // 头像
    lazy var photoImageView: UIImageView = {
        
        let img = UIImageView()
        
        img.image = UIImage(named: "avatar_default_big")
        
        // ???? 是除以 4 还是除以 2
        img.layer.cornerRadius = 170 / 2.0 / 2.0
        
        img.layer.masksToBounds = true
        // 边框的宽度
        img.layer.borderWidth = 3
        // 边框的颜色
        img.layer.borderColor = UIColor.yellow.cgColor
        
        // 设置大小
        
        return img
        
        
    }()
    lazy var nameLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = "欢迎归来"
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = UIColor.darkGray
        return lbl
    }()
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
