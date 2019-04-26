//
//  SinaTabBar.swift
//  WeiBo
//
//  Created by Chen on 2019/4/25.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit

class SinaTabBar: UITabBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        addSubview(composeButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        composeButton.center = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5)
        var index = 0
        let width = bounds.width / 5
        for subView in subviews{
            if subView.isKind(of: NSClassFromString("UITabBarButton")!){
                subView.frame = CGRect(x: CGFloat(index) * width, y: bounds.origin.y, width: width, height: bounds.height)
                index = index+1
                if index == 2{
                    index = index+1
                }
                print("index\(index)")
            }
            
        }
        
        
    }
    lazy var composeButton:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: UIControl.State.normal)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: UIControl.State.highlighted)
        
        button.setImage(UIImage(named: "tabbar_compose_icon_add"),for: UIControl.State.normal)
        button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: UIControl.State.highlighted)
        button.sizeToFit()
        
        return button
    }()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
