//
//  SinaHomeTableViewController.swift
//  WeiBo
//
//  Created by Chen on 2019/4/25.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD
let SinaHomeReuserIdentifer = "SinaHomeReuserIdentifer"
class SinaHomeTableViewController: SinaBaseTableViewController {

    lazy var viewModel:SinaStatusListViewModel = SinaStatusListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isLogin{
            vistor?.setupInfo(message: "关注一些人，回这里看看有什么惊喜", image: nil)
        }else{
            getData()
            //设置重用标示
            tableView.register(SinaHomeTableViewCell.self, forCellReuseIdentifier: SinaHomeReuserIdentifer)
            
            
            // 固定的高度 -- 直接告诉系统,cell高度都是 200
            tableView.rowHeight = 200
            // 自动计算告诉
            tableView.rowHeight = UITableView.automaticDimension
        }
       
        // Uncomment theSinaHomeTableViewControllerserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func getData(){
        viewModel.getData(success: {
            self.tableView.reloadData()
        }) {
            print("获取数据失败了")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SinaHomeReuserIdentifer, for: indexPath) as! SinaHomeTableViewCell
        
        cell.statusViewModel = viewModel.list[indexPath.row]


        return cell
    }


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
