//
//  YKRefreshFotterView.swift
//  YKRefreshControl
//
//  Created by C on 15/7/29.
//  Copyright (c) 2015年 SK. All rights reserved.
//

import UIKit

enum YKFooterRefreshState: Int {
    case None = 0
    case Refreshing
    case NotValue
}


public class YKRefreshFotterView: YKRefreshView {
    public var footerClosure:()->() = {}
    public var textLabel: UILabel!
//    public var state: YKFooterRefreshState = .None{
//        didSet {
//            switch state {
//            case .None:
//                println("none")
//            case .Refreshing:
//                println("refreshing")
//            case .NotValue:
//                println("notvalue")
//            }
//        }
//    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.autoresizingMask = .FlexibleWidth
        textLabel = UILabel()
        textLabel.frame = bounds
        textLabel.textAlignment = .Center
        textLabel.backgroundColor = UIColor.yellowColor()
        textLabel.text = "textLabel"
        addSubview(textLabel)

    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func willMoveToSuperview(newSuperview: UIView!) {
        superview?.removeObserver(self, forKeyPath: KVO_CONTENTSIZE, context: nil)
        superview?.removeObserver(self, forKeyPath: KVO_PANSTATE, context: nil)
        if (newSuperview != nil) {
            newSuperview.addObserver(self, forKeyPath: KVO_PANSTATE, options: .New, context: nil)
            newSuperview.addObserver(self, forKeyPath: KVO_CONTENTSIZE, options: .New, context: nil)
        }
    }
    deinit {
        let scrollView = superview as! UIScrollView
        scrollView.removeObserver(self, forKeyPath: KVO_CONTENTSIZE, context: nil)
        scrollView.removeObserver(self, forKeyPath: KVO_PANSTATE, context: nil)
    }

  public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    
  }
}
