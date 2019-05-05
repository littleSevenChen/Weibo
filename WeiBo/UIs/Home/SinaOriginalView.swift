//
//  SinaOriginalView.swift
//  WeiBo
//
//  Created by Chen on 2019/4/28.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit
class SinaOriginalView: UIView {
    // 定义一个全局的约束来记录 底部约束
    var picConstain: Constraint?    //定义一个属性
    var orginalViewModel: SinaStatusViewModel?{
        
        didSet{
            
            // 赋值
            //昵称赋值
            nameLabel.text = orginalViewModel?.model?.user?.screen_name
            //头像
            photoImageView.sd_setImage(with: orginalViewModel?.profile_URL as URL?, completed: nil)
            
            // 认证头像
            verifitiedImageView.image = orginalViewModel?.verifited_Image
            
            // 等级
            levelImageView.image = orginalViewModel?.vipLevel_Image
            //            timeLabel.text = orginalViewModel.
            // 来源
            sourceLabel.text = orginalViewModel?.source_string
            
            //
            contentLabel.text = orginalViewModel?.model?.text
            
            //            picConstain?.uninstall()
            //            //
            //            if orginalViewModel?.model?.pic_urls?.count ?? 0 > 0 {
            //                // 肯定有配图,然后显示配图
            //
            //                self.snp_updateConstraints({ (make) -> Void in
            //                    picConstain = make.bottom.equalTo(pictureView.snp_bottom).constraint
            //                })
            //
            //                pictureView.isHidden = false
            //
            //                //传递给配图试图
            //                pictureView.pictures = orginalViewModel?.model?.pic_urls
            //
            //            } else {
            //                // 没有配图,然后隐藏配图snp_remakeConstraints
            //                self.snp_updateConstraints({ (make) -> Void in
            //                    picConstain = make.bottom.equalTo(contentLabel.snp_bottom).constraint
            //                })
            //                pictureView.isHidden = true
            //            }
        }
        
    }
    
    // 1 重写 init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 2 添加子控件和约束
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(){
        
        
        // 添加子控件
        addSubview(photoImageView)
        addSubview(nameLabel)
        addSubview(levelImageView)
        addSubview(verifitiedImageView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        addSubview(contentLabel)
        
        // 添加约束

        // 头像的约束 距离顶部和左边有一个间距 10 ,固定宽高 40 40
        photoImageView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp_left).offset(SinaHomeMargin)
            make.top.equalTo(self.snp_top).offset(SinaHomeMargin)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        // 昵称的约束,距离头像右边 10 距离定边 10
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(photoImageView.snp_right).offset(SinaHomeMargin)
            make.top.equalTo(self.snp_top).offset(SinaHomeMargin)
            
        }
        
        // 等级图片的约束 -- 距离昵称的右边一个距离 , 和 昵称的水平中心对其
        levelImageView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(nameLabel.snp_right).offset(SinaHomeMargin)
            make.centerY.equalTo(nameLabel.snp_centerY)
        }
        
        verifitiedImageView.snp_makeConstraints { (make) -> Void in
            
            make.centerX.equalTo(photoImageView.snp_right)
            make.centerY.equalTo(photoImageView.snp_bottom)
            
        }
        
        // 时间的约束
        timeLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(photoImageView.snp_right).offset(SinaHomeMargin)
            
            make.top.equalTo(nameLabel.snp_bottom).offset(SinaHomeMargin/2)
            
        }
        
        
        sourceLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(timeLabel.snp_right).offset(SinaHomeMargin)
            
            make.centerY.equalTo(timeLabel.snp_centerY)
        }
        
        // 内容的约束
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp_left)
            make.top.equalTo(photoImageView.snp_bottom).offset(SinaHomeMargin)
            make.width.equalTo(UIScreen.main.bounds.width)
            //            make.bottom.equalTo(self.snp_bottom)
            
        }
        self.snp.makeConstraints { (make) in
            make.bottom.equalTo(contentLabel.snp.bottom)
        }
    }
    
    //3
    //MARK:--懒加载
    ///   头像
    lazy var photoImageView: UIImageView = {
        
        let img = UIImageView()
        
        img.image = UIImage(named: "avatar_default_big")
        
        return img
    }()
    
    ///   昵称
    lazy var nameLabel: UILabel = {
        
        let label = UILabel()
        
        
        label.text = " 昵称"
        
        label.font = UIFont.systemFont(ofSize: 14)
        
        label.textColor = UIColor.black
        
        
        return label
    }()
    
    ///  等级图片
    lazy var levelImageView: UIImageView = {
        
        
        let img = UIImageView()
        
        img.image = UIImage(named: "common_icon_membership_level1")
        
        return img
        
    }()
    
    ///  认证图片
    lazy var verifitiedImageView: UIImageView = {
        
        let img = UIImageView()
        
        
        img.image = UIImage(named: "avatar_enterprise_vip")
        
        return img
        
    }()
    
    ///   时间
    lazy var timeLabel: UILabel = {
        
        let label = UILabel()
        
        
        label.text = "时间"
        
        label.font = UIFont.systemFont(ofSize: 14)
        
        label.textColor = UIColor.orange
        
        
        return label
    }()
    
    ///   来源
    lazy var sourceLabel: UILabel = {
        
        let label = UILabel()
        
        
        label.text = "来源"
        
        label.font = UIFont.systemFont(ofSize: 14)
        
        label.textColor = UIColor.darkGray
        
        
        return label
    }()
    
    
    // 内容
    lazy var contentLabel: UILabel = {
        
        let label = UILabel()
        
        
        label.text = "来源"
        
        label.font = UIFont.systemFont(ofSize: 14)
        
        label.textColor = UIColor.black
        
        label.numberOfLines = 0
        
        return label
    }()
    ///  配图试图
    lazy var pictureView: SinaPictureView = SinaPictureView()
}
