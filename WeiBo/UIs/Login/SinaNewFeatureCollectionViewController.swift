//
//  SinaNewFeatureCollectionViewController.swift
//  WeiBo
//
//  Created by Chen on 2019/4/28.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
let count = 4
class SinaNewFeatureCollectionViewController: UICollectionViewController {
 let flowLayout = UICollectionViewFlowLayout()
   required init() {
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        setupUI()

        // Do any additional setup after loading the view.
    }
    
     func setupUI(){
        collectionView.register(SinaNewFeatureCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        flowLayout.itemSize = UIScreen.main.bounds.size
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
    }
    
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        // Configure the cell
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SinaNewFeatureCollectionViewCell
         cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.yellow
        cell.index = indexPath.item
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

class SinaNewFeatureCollectionViewCell: UICollectionViewCell {
    var index:Int = 0{
        didSet{
            iconImageView.image = UIImage(named: "new_feature_\(index + 1)")
            if index == 3{
                enterButton.isHidden = false
            }else{
                enterButton.isHidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        addSubview(iconImageView)
        addSubview(enterButton)
        
        // 设置约束 -- 直接设置 frame
        iconImageView.frame = bounds
        //设置 约束 -- 水平居中 ,距离cell的底部 150
        
        //第一步一定要关掉 translatesAutoresizingMaskIntoConstraints
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        
        // 这个约束是添加到 button上还是 添加到 button的父试图 cell上
        // 约束要添加到 cell,!!!!!!!!!!!千万不要添加到 enterButton.addConstraint
        addConstraint(NSLayoutConstraint(item: enterButton, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: enterButton, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: -150))
        
    }
    lazy var iconImageView:UIImageView = {
        let img = UIImageView()
        return img
    }()
    //进入按钮
    lazy var enterButton: UIButton = {
        
        let button = UIButton(type: UIButton.ButtonType.custom)
        
        //设置图片
        
        button.setBackgroundImage(UIImage(named: "new_feature_finish_button"), for: UIControl.State.normal)
        button.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), for: UIControl.State.highlighted)
        
        // 设置标题
        button.setTitle("立即进入", for: UIControl.State.normal)
        
        // 文字颜色
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        
        // 2中方式 --
        // 可以用 sizeToFit 是背景图片的时候,这个大小可以被背景图片所撑开
        // 第二种方式: 设置约束或者 frame, 这个方式是不是 我们大小自己可以设置或者不确定的时候
        button.sizeToFit()
        // 添加一个按钮点击事件
        button.addTarget(self, action: #selector(enter), for: UIControl.Event.touchUpInside)
        return button
        
    }()
    @objc func enter(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotificationEnter), object: nil)
    }
}
