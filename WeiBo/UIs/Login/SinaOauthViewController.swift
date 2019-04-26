//
//  SinaOauthViewController.swift
//  WeiBo
//
//  Created by Chen on 2019/4/26.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit
import SVProgressHUD
import WebKit
import AFNetworking
//appKey 740300893
//appSecret 2c57263dd1ace2df39dde73f74a13b70
class SinaOauthViewController: UIViewController,WKNavigationDelegate {

    let webView = WKWebView()
    let redirect_Url = "http://www.baidu.com"
    let app_Key = "740300893"
    let app_Secret = "2c57263dd1ace2df39dde73f74a13b70"
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        view = webView
        setupNav()
        view.backgroundColor = UIColor.white
        let url = NSURL(string: "https://api.weibo.com/oauth2/authorize?client_id=740300893&redirect_uri=http://www.baidu.com")
        // 1.2 创建一个 请求 -- 这个url可以强制解包,因为这个url是写死的
        let request = NSURLRequest(url: url! as URL)
        // 1.3 加载
        webView.load(request as URLRequest)
        
        
        // 2. 设置代理,然后拿到 url
       
        
        // Do any additional setup after loading the view.
    }
    
    func setupNav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backItemClick))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style: UIBarButtonItem.Style.plain, target: self, action: #selector(outoFill))
    }
    @objc func backItemClick(){
        navigationController?.dismiss(animated: true, completion:nil)
    }
    @objc func outoFill(){
        // 1 js -- \是转义字符
       
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

extension SinaOauthViewController{
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
       print("页面开始加载时调用")
        SVProgressHUD.show()
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("页面加载完成之后调用")
        print(navigation)
        SVProgressHUD.dismiss()
    }
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        decisionHandler(WKNavigationActionPolicy);
        decisionHandler(WKNavigationActionPolicy.allow)
       let strRequest = navigationAction.request.url?.absoluteString
        if let url = strRequest {
            if url.hasPrefix(redirect_Url){
                if let code = navigationAction.request.url?.query{
                    let index = code.index(code.startIndex, offsetBy: 5)
                    let subStr = String(code.suffix(from: index))
                     print(subStr)
                    getToken(code: subStr, success: {
                        print("成功了")
                    }) { (error) -> () in
                        print(error)
                    }
//                    似成相识路中人
                }
            }
        }
       
    }
    
    //MARK：获取网络请求来获取token
    private func getToken(code:String,success: @escaping ()->(),falure:@escaping (_ error:NSError)->()){
        let afn = AFHTTPSessionManager()
        afn.responseSerializer.acceptableContentTypes?.insert("text/plain")
        let params = [ "client_id": app_Key,
                       "client_secret":app_Secret,
                       "grant_type":"authorization_code",
                       "code":code,
                       "redirect_uri":redirect_Url
            
        ]
        afn.post("https://api.weibo.com/oauth2/access_token", parameters: params, success: { (_ , JSON) -> Void in
            
//            print("=====\(JSON ?? nil)")
            let dic = JSON as? [String:AnyObject]
            if let dict = dic{
                let account = SinaAccountModel(dict: dict)
                self.personalInfo(accountModel: account, success: success, failure: falure)
                 print(account)
            }
           
            /*
             "access_token" = "2.00cYTHKG0gkcu5a8f698925cEIKSwB";
             "expires_in" = 157679999;
             "remind_in" = 157679999;
             uid = 5646342270;
             */
            
        }) { (_ , error) -> Void in
            print(error)
        }
    }
    //MARK  获得token后，获取个人信息
    private func personalInfo(accountModel:SinaAccountModel,success:@escaping ()->(),failure:(_ errot:NSError)->()){
        if accountModel.access_token == nil || accountModel.uid == nil {
            fatalError("access_token或者uid为nil")
        }
        let afn = AFHTTPSessionManager()
        let  params = ["access_token": accountModel.access_token!,
                       "uid":accountModel.uid!]
        afn.get("https://api.weibo.com/2/users/show.json", parameters: params, progress: nil, success: { (_, JSON) in
            if let dic = JSON as? [String:AnyObject]{
                accountModel.screen_name = dic["screen_name"] as? String
                accountModel.profile_image_url = dic["profile_image_url"] as? String
                accountModel.saveInfo()
                success()
            }
           
        }) { (_, error) in
            print(error)
        }

    }
    
   
}
