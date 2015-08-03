//
//  ViewController.swift
//  YKRefreshControl
//
//  Created by C on 15/7/13.
//  Copyright (c) 2015年 SK. All rights reserved.
//

import UIKit




class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.lightGrayColor()
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height-64), style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.addHeaderViewWithClosure { () -> () in
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
                self.tableView.stopRefresh()
            })
        }
        tableView.startRefresh()
        tableView.addFooterViewWithClosure { () -> () in
            println("下边的")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell!
        cell.textLabel!.text = "测试"
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc : UIViewController = UIViewController()
        vc.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


