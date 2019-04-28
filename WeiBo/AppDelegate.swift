//
//  AppDelegate.swift
//  WeiBo
//
//  Created by Chen on 2019/4/25.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = SinaAccountViewModel.shareInstance.isLogin ? (retureDefaultViewController()) : (SinaTabBarController())
        NotificationCenter.default.addObserver(self, selector: #selector(changeVc(noti:)), name: NSNotification.Name(rawValue: kNotificationEnter), object: nil)
        setupAppereance()
        return true
    }
    private func setupAppereance(){
        UINavigationBar.appearance().tintColor = UIColor.orange
        UITabBar.appearance().tintColor = UIColor.orange
    }
    @objc func changeVc(noti:Notification){
        // noti.object 如果有值 就是 认证界面发过来的通知
        // 如果说 没有值,就是 欢迎页面发过来的
        if noti.object == nil{
            window?.rootViewController = SinaTabBarController()
        }else{
            window?.rootViewController = SinaWelcomeViewController()
        }
    }
    func retureDefaultViewController() ->UIViewController{
        // 如果是新版本,返回一个 新特性的控制
        // 如果不是新版本,直接跳转到欢迎页面
        return checkVerson() ? (SinaNewFeatureCollectionViewController ()) : (SinaWelcomeViewController())
    }
    
    // 检测版本的方法
    private func checkVerson() -> Bool {
        
        return true
        
    }
    deinit{
        removeObserver(self, forKeyPath: kNotificationEnter)
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

