//
//  YKNavigationController.swift
//  YKRefreshControl
//
//  Created by C on 15/7/22.
//  Copyright © 2015年 SK. All rights reserved.
//

import UIKit

class YKNavigationController: UINavigationController {

    override class func initialize() {
        let navibar = UINavigationBar.appearance()
        navibar.tintColor = UIColor.whiteColor()
        let navBarBg = "NavBar64"
        navibar.setBackgroundImage(UIImage(named: navBarBg), forBarMetrics: UIBarMetrics.Default)
    }
}
