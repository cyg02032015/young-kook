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
    
    func addHeaderViewWithClosure(action: ()->()){
        let ykRefresh = YKRefreshHeaderView(frame: CGRect(x: 0, y: -RefreshViewH, width: ScreenWidth, height: RefreshViewH))
        ykRefresh.tag = 100
        addSubview(ykRefresh)
        ykRefresh.action = action
    }
    func addFooterViewWithClosure(action: ()->()) {
        let ykFooterView = YKRefreshFotterView(frame: CGRect(x: 0, y: frame.size.height, width: ScreenWidth, height: RefreshViewH))
        addSubview(ykFooterView)
    }
    func startRefresh(){
        ykRefreshView!.startRefreshing()
    }
    func stopRefresh() {
        ykRefreshView!.stopRefreshing()
    }
}