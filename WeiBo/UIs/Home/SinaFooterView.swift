//
//  SinaFooterView.swift
//  WeiBo
//
//  Created by Chen on 2019/4/28.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit

class SinaFooterView: UIView {
    
    // 定义一个model
    var footerViewModle: SinaStatusViewModel? {
        
        didSet{
            retweetButton.setTitle(footerViewModle?.reposts_string, for: UIControl.State.normal)
            commentsButton.setTitle(footerViewModle?.comments_string, for: UIControl.State.normal)
            goodButton.setTitle(footerViewModle?.attitudes_string, for: UIControl.State.normal)
            
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
    
    
    //2
    private func setupUI(){
        
        addSubview(commentsButton)
        addSubview(retweetButton)
        addSubview(goodButton)
        
        
        
        
        /// 添加约束
        // 评论按钮的约束 -- 左边.上边.下边,   宽度和转发按钮一致
        commentsButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp_left)
            make.top.equalTo(self.snp_top)
            make.bottom.equalTo(self.snp_bottom)
            
            //
            make.width.equalTo(retweetButton.snp_width)
        }
        
    
        //点赞按钮的约束 -- 上边.右边,下边 ,, 宽度和转发按钮一致
        
        goodButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top)
            make.right.equalTo(self.snp_right)
            make.bottom.equalTo(self.snp_bottom)
            
            //
            make.width.equalTo(retweetButton.snp_width)
        }
        
        // 转发按钮 , 上边,下边和 self一致 ,,,,, 左边是 评论按钮 ,右边是 点赞按钮
        retweetButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top)
            make.bottom.equalTo(self.snp_bottom)
            
            //
            make.left.equalTo(commentsButton.snp_right)
            make.right.equalTo(goodButton.snp_left)
        }
        
        //MARK:--添加2条竖线
        let line1 = getLine()
        let line2 = getLine()
        addSubview(line1)
        addSubview(line2)
        
        //设置约束
        line1.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.snp_centerY)
            
            make.left.equalTo(commentsButton.snp_right)
        }
        
        line2.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.snp_centerY)
            
            make.left.equalTo(retweetButton.snp_right)
        }
        
    }
    
    //MARK:--懒加载 3
    ///  转发按钮
    lazy var retweetButton: UIButton = {
        
        let buttton = UIButton(type: UIButton.ButtonType.custom)
        buttton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        buttton.setImage(UIImage(named: "timeline_icon_retweet"), for: UIControl.State.normal)
        buttton.setTitle("转发", for: UIControl.State.normal)
        buttton.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
        
        return buttton
    }()
    
    ///  评论按钮
    lazy var commentsButton: UIButton = {
        
        let buttton = UIButton(type: UIButton.ButtonType.custom)
        buttton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        buttton.setImage(UIImage(named: "timeline_icon_comment"), for: UIControl.State.normal)
        buttton.setTitle("评论", for: UIControl.State.normal)
        buttton.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
        
        return buttton
    }()
    ///点赞按钮
    
    lazy var goodButton: UIButton = {
        
        let buttton = UIButton(type: UIButton.ButtonType.custom)
        buttton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        buttton.setImage(UIImage(named: "timeline_icon_like"), for: UIControl.State.normal)
        buttton.setTitle("赞", for: UIControl.State.normal)
        buttton.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
        
        return buttton
    }()
    
    // 创造一条线
    private func getLine() -> UIImageView {
        
        return UIImageView(image: UIImage(named: "timeline_card_bottom_line_highlighted"))
        
    }
    
}
