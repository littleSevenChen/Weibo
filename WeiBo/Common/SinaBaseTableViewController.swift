//
//  SinaBaseTableViewController.swift
//  WeiBo
//
//  Created by Chen on 2019/4/25.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit

class SinaBaseTableViewController: UITableViewController,SinaVisitorViewDelegate{
    @objc func didLoginMethod() {
        print("didLoginMethod")
    }
    
    @objc func didResgisterMethod() {
        print("didResgisterMethod")
        let oauthVC = SinaOauthViewController()
        let nav = UINavigationController(rootViewController: oauthVC)
        present(nav, animated: true, completion: nil)
    }
    
    
    let account = SinaAccountModel.readInfo()
    var isLogin = false
    var vistor:SinaVisitorView?
    
    override func loadView() {
//        isLogin = (SinaAccountViewModel.shareInstance.access_token == "" ) ? false : true
        isLogin = SinaAccountViewModel.shareInstance.isLogin
        if isLogin {
            super.loadView()
        }else{
            vistor = SinaVisitorView()
            vistor?.startAnimition()
            vistor?.delegate = self
            setupNav()
            view = vistor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    // 设置nav
    private func setupNav(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItem.Style.plain, target: self, action:#selector(didResgisterMethod))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItem.Style.plain, target: self, action: #selector(didLoginMethod))
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
