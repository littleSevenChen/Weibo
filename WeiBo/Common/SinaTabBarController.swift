//
//  SinaTabBarController.swift
//  WeiBo
//
//  Created by Chen on 2019/4/25.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit

class SinaTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor.orange
        addchildController()
        
       
        
        let tabBar = SinaTabBar()
        setValue(tabBar, forKey: "tabBar")
        tabBar.composeButton.addTarget(self, action: #selector(publish), for: UIControl.Event.touchUpInside)
        // Do any additional setup after loading the view.
    }
    @objc func publish() {
        print("dianjil")
    }
    func addchildController() {
        addChildViewController(childController: SinaHomeTableViewController(), title: "首页", image: "tabbar_home")
        addChildViewController(childController: SinaMessageTableViewController(), title: "消息", image: "tabbar_message_center")
        addChildViewController(childController: SinaFindTableViewController(), title: "发现", image: "tabbar_discover")
        addChildViewController(childController: SinaSettingTableViewController(), title: "设置", image: "tabbar_profile")
    }
    
    func addChildViewController(childController:UIViewController?,title:String,image:String)  {
        childController?.title = title;
        childController?.tabBarItem.image = UIImage(named: image)
        childController?.tabBarItem.selectedImage = UIImage(named: "\(image)_highlighted")
        let nav = UINavigationController(rootViewController: childController!)
        addChild(nav)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
