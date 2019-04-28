//
//  SinaHomeTableViewCell.swift
//  WeiBo
//
//  Created by Chen on 2019/4/28.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit

class SinaHomeTableViewCell: UITableViewCell {
    
    //MVVM
    var statusViewModel: SinaStatusViewModel?{
        //
        didSet{
            
            originalView.orginalViewModel = statusViewModel
            
        }
    }
    
    //    //MVC
    //    var model: SinaStatusModel?{
    //
    //        didSet{
    //
    //           let url =  NSURL(string: model?.user?.profile_image_url ?? "")
    //        }
    //
    //    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //添加子控件和约束
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //
    private func setupUI(){
        
        // 添加 -- contentView 第一个 苹果推荐我们用这个  第二个,可以动态的计算
        contentView.addSubview(originalView)
        
        
        // 添加约束 --
        originalView.snp_makeConstraints { (make) -> Void in
            // 第一点 contentView
            // 第二点 snp_left
            make.left.equalTo(contentView.snp_left)
            make.top.equalTo(contentView.snp_top)
            make.width.equalTo(contentView.snp_width)
            
            
            make.bottom.equalTo(contentView.snp_bottom)
        }
        
    }
    
    //MARK:--懒加载
    lazy var originalView: SinaOriginalView = SinaOriginalView()
    
}
