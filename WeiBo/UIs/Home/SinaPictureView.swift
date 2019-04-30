//
//  SinaPictureView.swift
//  WeiBo
//
//  Created by Chen on 2019/4/28.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

/*
 1. item的宽高要改
 2. 配图的左右约束要改 --  2个地方都要改,原创微博和转发微博
 3. 配图的宽度也要改
 */

let picMargin: CGFloat = 5
let itemMargin: CGFloat = 5
let itemWidth = (CGFloat(kUIScreenWidth) - CGFloat( 2 * itemMargin) - CGFloat( 2 * SinaHomeMargin))/CGFloat (3.0)


// 可重用的 重用标示符
let SinaPictureViewReuseIdentifier = "SinaPictureViewReuseIdentifier"

class SinaPictureView: UICollectionView ,UICollectionViewDataSource{
  
    
    
    // 定义一个变量
    var pictures: [SinaPictureModel]?{
        
        didSet{
            
            ////////!!!!!!!!!!!!!!!!!!第一大步 计算 pictureView的宽高
            ////////把宽高更新一下约束
            let size = getSize()
            
            // 宽高计算好了之后给试图更新,因为有重用,所以我们需要 更新 update
            snp_updateConstraints { (make) -> Void in
                make.width.equalTo(size.width)
                make.height.equalTo(size.height)
            }
            
            textLabel.text = "\(pictures?.count ?? 0)"
            
            // 当赋值的时候一定要记得 reloadData
            //
            reloadData()
        }
        
    }
    
    init(){
        super.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize.zero), collectionViewLayout: UICollectionViewFlowLayout())
        
        
        addSubview(textLabel)
        
        textLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp_centerX)
            make.centerY.equalTo(self.snp_centerY)
        }
        
        ////////!!!!!!!!!!!!!!!!!!第二大步 设置代理方法,然后设置布局
        // 实现数据源方法
        dataSource = self
        //注册cell
        // !!!!!!!!!!!!!!!!!自定义的cell 一定要替换
        register(SinaPictureViewCollectionViewCell.self, forCellWithReuseIdentifier: SinaPictureViewReuseIdentifier)
        
        // 设置 item
        // 获取系统的 布局,强制转换成流水布局
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        
        //间距
        flowLayout.minimumInteritemSpacing = itemMargin
        flowLayout.minimumLineSpacing = itemMargin
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func getSize() ->CGSize {
        
        /*
         计算配图的宽高
         高度是图片的高度
         
         
         
         一张图片给他一个固定的宽高
         
         4张图片的时候返回一个 2*2的吧
         
         2,3 一个图片的高度,宽度是一个屏幕的宽度
         5,6, 2*图片的高度+间距,宽度 一个屏幕的宽度
         7,8,9 3*图片的高度+ 2*间距,宽度 一个屏幕的宽度
         
         */
        
        
        let count = pictures?.count
        
        if count == 1 {
            
            // 一张图片给他一个固定的宽高
            return CGSize(width: itemWidth, height: itemWidth)
            
        } else if count == 4 {
            
            //  4张图片的时候返回一个 2*2的吧
            return CGSize(width: itemWidth * 2 + itemMargin, height: itemWidth * 2 + itemMargin)
        
        } else {
            
            /*
             2,3 一个图片的高度,宽度是一个屏幕的宽度
             5,6, 2*图片的高度+间距,宽度 一个屏幕的宽度
             7,8,9 3*图片的高度+ 2*间距,宽度 一个屏幕的宽度
             */
            
            let row = (count! - 1 ) / 3 + 1
            
            let heigth = CGFloat(row) * (itemWidth) + (CGFloat(row) - 1) * itemMargin
            return CGSize(width: CGFloat( kUIScreenWidth - 2 * CGFloat( SinaHomeMargin)), height: heigth)
        }
        
        return CGSize.zero
        
    }
    
    //添加一个测试Label
    lazy var textLabel: UILabel = UILabel()
}


extension SinaPictureView {
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 想到重用就要想起来注册 cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SinaPictureViewReuseIdentifier, for: indexPath as IndexPath) as! SinaPictureViewCollectionViewCell
        
        // 为了测试.返回的cell背景颜色改一下
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.yellow : UIColor.red
        
        cell.photoModel = pictures![indexPath.item]
        
        return cell
    }
 
    
}

////////!!!!!!!!!!!!!!!!!!第三大步 自定义cell

class SinaPictureViewCollectionViewCell: UICollectionViewCell {
    
    // 5 设置模型
    var photoModel: SinaPictureModel?{
        didSet{
            
            // 图片赋值
            let url = NSURL(string: photoModel?.thumbnail_pic ?? "")
            iconImageView.sd_setImage(with: url as URL? , completed: nil)
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
        
        // 4
        addSubview(iconImageView)
        
        // 4.1
        iconImageView.frame = bounds
        
    }
    
    
    //MARK:--懒加载 -- 3
    // 这个属性用来展示图片
    lazy var iconImageView: UIImageView = UIImageView()
}

