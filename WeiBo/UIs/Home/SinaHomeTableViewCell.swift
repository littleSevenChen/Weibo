//
//  SinaHomeTableViewCell.swift
//  WeiBo
//
//  Created by Chen on 2019/4/28.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit
import SnapKit
class SinaHomeTableViewCell: UITableViewCell {
    //声明一个全局的约束
    var bottomConstant: Constraint?
    //MVVM
    var statusViewModel: SinaStatusViewModel?{
        //
        didSet{
            
            originalView.orginalViewModel = statusViewModel
            footerView.footerViewModle = statusViewModel
            retweetView.backgroundColor = UIColor.red
//            // 由于cell有重用的机制,bottomConstant会记录重用之前的约束,如果不把这个约束清除的话,会影响我们的布局
            //先卸载掉之前重用的时候的约束
            bottomConstant?.uninstall()
//             就是原创微博 -- 转发微博的试图应该隐藏
            if statusViewModel?.model?.retweeted_status == nil {

//                footerView.snp_updateConstraints({ (make) -> Void in
//                    bottomConstant =  make.top.equalTo(originalView.snp_bottom).constraint
//                })
//                footerView.snp.updateConstraints { (make)->Void in
//                     bottomConstant =  make.top.equalTo(originalView.snp_bottom).constraint
//                }
//
                retweetView.isHidden = true

            } else {
                //就是转发微博 -- 转发微博的试图不隐藏

                footerView.snp_updateConstraints({ (make) -> Void in
                    bottomConstant = make.top.equalTo(retweetView.snp_bottom).constraint
                })


                retweetView.isHidden = false

                retweetView.retweetViewModel = statusViewModel
            }
            
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
        contentView.addSubview(retweetView)
        contentView.addSubview(footerView)
        
//        // 添加约束 --
        originalView.snp_makeConstraints { (make) -> Void in
            // 第一点 contentView
            // 第二点 snp_left
            make.left.equalTo(contentView.snp_left)
            make.top.equalTo(contentView.snp_top)
            make.width.equalTo(contentView.snp_width)
//            make.bottom.equalTo(contentView.snp_bottom)
        }

    

        // 转发微博的约束怎么加 -- 上下宽
        retweetView.snp_makeConstraints { (make) -> Void in
            
            make.width.equalTo(contentView.snp_width)
            
            make.top.equalTo(originalView.snp_bottom)
            
            //            make.height.equalTo(20)
        }
        
        
        //
        footerView.snp_makeConstraints { (make) -> Void in

            //
            make.left.equalTo(contentView.snp_left)
            make.width.equalTo(contentView.snp_width)
            make.height.equalTo(44)
            // 有没有转发微博,这个约束才是最关键的
            bottomConstant = make.top.equalTo(retweetView.snp_bottom).constraint
            make.bottom.equalTo(contentView.snp_bottom)
        }
//        contentView.snp_makeConstraints { (make) -> Void in
//            make.bottom.equalTo(footerView.snp_bottom)
//            make.width.equalTo(self.snp_width)
////            make.right.equalTo(originalView.snp_right)
//            make.top.equalTo(self.snp_top)
//        }
//        //这个一定要记住,设置contentView约束的时候,一定要告诉他其他的边界
//        contentView.snp_makeConstraints { (make) -> Void in
//            make.bottom.equalTo(footerView.snp_bottom)
////            // 后期出现问题的时候,我们再来分析一下
////            make.width.equalTo(self.snp_width)
////            //!!!!!!!!!!这个约束一定要注意
////            make.top.equalTo(self.snp_top)
//            make.left.equalTo(self.snp_left)
//            make.top.equalTo(self.snp_top)
//            make.right.equalTo(self.snp_right)
//            make.bottom.equalTo(footerView.snp_bottom)
//        }
//        
    }
    
    //MARK:--懒加载
    lazy var originalView: SinaOriginalView = SinaOriginalView()
    
    //转发试图
    lazy var retweetView: SinaRetweetView = SinaRetweetView()
    
    
    ///  底部工具栏
    lazy var footerView: SinaFooterView = SinaFooterView()
    
}
