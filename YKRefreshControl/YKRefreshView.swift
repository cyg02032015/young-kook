//
//  YKRefreshView.swift
//  YKRefreshControl
//
//  Created by C on 15/7/13.
//  Copyright (c) 2015年 SK. All rights reserved.
//

import UIKit



public class YKRefreshView: UIView {
    public var scrollView: UIScrollView!
    public var previousOffSet: CGFloat = 0
    public var scrollViewInsets: UIEdgeInsets = UIEdgeInsetsZero
    public var scrollViewBouncesDefaultValue: Bool = false
    public var scrollViewInsetsDefaultValue : UIEdgeInsets = UIEdgeInsetsZero

        override init(frame: CGRect) {
        super.init(frame: frame)
        self.autoresizingMask = .FlexibleWidth
        self.backgroundColor = UIColor.clearColor()
    }
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func willMoveToSuperview(newSuperview: UIView!) {
        superview?.removeObserver(self, forKeyPath: KVO_CONTENTOFFSET, context: nil)
        if let asScrollView = newSuperview as? UIScrollView {
            scrollView = asScrollView
            scrollView.addObserver(self, forKeyPath: KVO_CONTENTOFFSET, options: .Initial, context: nil)
            scrollViewInsetsDefaultValue = scrollView.contentInset
        }
    }
    deinit {
        println("observed remove")
        scrollView?.removeObserver(self, forKeyPath: KVO_CONTENTOFFSET, context: nil)
        scrollView = nil
    }
    
    func startRefreshing() {
    }
    func stopRefreshing() {
    }
}


