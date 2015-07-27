//
//  UIScrollView+EXT.swift
//  YKRefreshControl
//
//  Created by C on 15/7/14.
//  Copyright (c) 2015年 SK. All rights reserved.
//

import UIKit


 let RefreshViewH: CGFloat = 50

extension UIScrollView {
    
    public var ykRefreshView: YKRefreshView? {
        get {
            let ykRefreshView = viewWithTag(100)
            return ykRefreshView as? YKRefreshView
        }
    }
    
    func addRefreshControl(action: ()->()) -> Void {
        let ykRefresh = YKRefreshView(frame: CGRect(x: 0, y: -RefreshViewH, width: UIScreen.mainScreen().bounds.width, height: RefreshViewH))
        ykRefresh.tag = 100
        addSubview(ykRefresh)
        ykRefresh.action = action
    }
    func startRefresh(){
        ykRefreshView!.startRefreshing()
    }
    func stopRefresh() {
        ykRefreshView!.stopRefreshing()
    }
}