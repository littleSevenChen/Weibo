//
//  SinaRetweetView.swift
//  WeiBo
//
//  Created by Chen on 2019/4/28.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit

class SinaRetweetView: UIView {
    
    var retweetViewModel: SinaStatusViewModel?{
        
        didSet{
            
            contentLabel.text = retweetViewModel?.model?.retweeted_status?.text
            
        }
        
    }
    
    // 1
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 2
    private func setupUI(){
        
        addSubview(contentLabel)
        
        // 设置约束
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp_left)
            make.top.equalTo(self.snp_top)
            make.width.equalTo(self.snp_width)
            
            
        }
        
        // 告诉转发微博的底部到 contentLabel的底部
        self.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(contentLabel.snp_bottom)
        }
    }
    
    //MARK:懒加载
    lazy var contentLabel: UILabel = {
        
        
        let  label = UILabel()
        
        label.textColor = UIColor.darkGray
        
        label.font = UIFont.systemFont(ofSize: 15)
        
        label.numberOfLines = 0
        
        return label
    }()
}

