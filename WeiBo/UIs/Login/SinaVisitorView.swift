//
//  SinaVisitorView.swift
//  WeiBo
//
//  Created by Chen on 2019/4/26.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit

class SinaVisitorView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        backgroundColor = UIColor.white
    }
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func staetAnimition() {
        let animitaion = CABasicAnimation(keyPath: "transform.rotation")
        animitaion.toValue = Double.pi
        animitaion.repeatCount = MAXFLOAT
        animitaion.duration = 20
        animitaion.isRemovedOnCompletion = false
        animationImageView.layer.add(animitaion, forKey: nil)
    }
    
    private lazy var animationImageView:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "visitordiscover_feed_image_smallicon")
        img.sizeToFit()
        return img
    }()
    //遮盖视图
    private lazy var maskImageView:UIImageView = {
        let img = UIImageView()
        
        img.image = UIImage(named: "visitordiscover_feed_mask_smallicon")
        
        return img
    }()
    //首页小房子
    private lazy var houseImgeView:UIImageView = {
        let img = UIImageView()
        
        img.image = UIImage(named: "visitordiscover_feed_image_house")
        
        return img
    }()
   //提示语
    private lazy var messageLabel:UILabel = {
        let lb = UILabel()
        lb.text = "关注一些人，回这里看看有什么惊喜  关注一些人，回这里看看有什么惊喜"
        lb.textColor = UIColor.darkGray
        lb.textAlignment = .center
        lb.numberOfLines = 0;
        return lb;
    }()
    //注册按钮
    private lazy var registerButton:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: UIControl.State.normal)
        button.setTitle("注册", for: UIControl.State.normal)
        button.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(registerMethod), for: UIControl.Event.touchUpInside)
        return button
    }()
    @objc  func registerMethod(){
        print("registerMethod")
    }
    //登录按钮
    private lazy var loginButton:UIButton = {
        let loginBtn = UIButton(type: UIButton.ButtonType.custom)
        loginBtn.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: UIControl.State.normal)
        
        loginBtn.setTitle("登录", for: UIControl.State.normal)
        
        loginBtn.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        
        // 按钮方法
        loginBtn.addTarget(self , action: #selector(loginMethod), for: UIControl.Event.touchUpInside)

        return loginBtn
    }()
    @objc func loginMethod(){
        print("loginMethod")
    }
}

extension SinaVisitorView{
    //MARK:--添加到试图里
    private func setupUI(){
        
        // 改一个背景颜色
        backgroundColor = UIColor(white: 237/255.0, alpha: 1.0)
        
        addSubview(animationImageView)
        addSubview(maskImageView)
        addSubview(houseImgeView)
        addSubview(messageLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        // 添加约束
        
        
        // 首页的动画图片约束 -- 水平居中,垂直居中
        // 关闭 系统  autosizing
        animationImageView.translatesAutoresizingMaskIntoConstraints = false
        houseImgeView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        // 手动添加约束
        /*
         item: <#T##AnyObject#>,  -- 要给哪个控件设置约束
         attribute: <#T##NSLayoutAttribute#>,  -- 设置对齐的方向
         relatedBy: <#T##NSLayoutRelation#>,  有三个选项,我们一般选用 equal
         toItem: <#T##AnyObject?#>,  -- 参照于哪个试图
         attribute: <#T##NSLayoutAttribute#>,
         multiplier: <#T##CGFloat#>,  系数 0~1
         constant: <#T##CGFloat#>    微调值
         
         Create constraints explicitly.  Constraints are of the form "view1.attr1 = view2.attr2 * multiplier + constant
         */
        addConstraint(NSLayoutConstraint(item: animationImageView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: animationImageView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0))
        
        
        //首页的小房子
        addConstraint(NSLayoutConstraint(item: houseImgeView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: houseImgeView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0))
        
        //提示label --
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: animationImageView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 10))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 224))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0))
        
        // 注册按钮 -- 宽 100,高 30 , 左边和 messageLabel的左边对其,顶部和其底部对齐
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 100))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 30))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: messageLabel, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: messageLabel, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 10))
        
        
        
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 100))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 30))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: messageLabel, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: messageLabel, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 10))
        
    }
    
    
}
