//
//  YKRefreshView.swift
//  YKRefreshControl
//
//  Created by C on 15/7/13.
//  Copyright (c) 2015年 SK. All rights reserved.
//

import UIKit

enum YKRefreshControlState : Int{
    case BeginRefresh = 0
    case Refreshing
    case None
}

public class YKRefreshView: UIView {
    var str : String?
    private weak var scrollView: UIScrollView!
    public var refreshLabel = UILabel()
    private var previousOffSet: CGFloat = 0
    private var scrollViewInsets: UIEdgeInsets = UIEdgeInsetsZero
    public var scrollViewBouncesDefaultValue: Bool = false
    private var scrollViewInsetsDefaultValue : UIEdgeInsets = UIEdgeInsetsZero
    public var action: ()->() = {}
    private var headerPercent: CGFloat!
    private var state: YKRefreshControlState = .None{

        didSet {
            if oldValue == state {return}
//            println("oldValue: \(oldValue) newValue: \(state)")
            switch state {
            case .Refreshing:
                UIView.animateWithDuration(0.5, delay: 0.0, options: [.AllowUserInteraction,.BeginFromCurrentState], animations: { () -> Void in
                    let top = self.scrollViewInsetsDefaultValue.top + RefreshViewH;
                    self.scrollView.contentInset.top = top;
                    self.scrollView.contentOffset.y = -top;
                    self.setTitle("qqqq", forState: YKRefreshControlState.Refreshing)
                    }, completion: { (finish) -> Void in
                    if self.action != nil {
                        self.action()
                    }
                })
                break
            case .BeginRefresh:
                setTitle("松手就刷新", forState: YKRefreshControlState.BeginRefresh)
            case .None:
                if oldValue == .Refreshing {
                    UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                        self.setTitle("刷新完成", forState: YKRefreshControlState.None)
                        self.scrollView.contentInset.top -= RefreshViewH
                        }, completion: { (finish) -> Void in
                            self.setTitle("Pull To Refresh", forState: YKRefreshControlState.None)
                            self.scrollView.contentInset.top += RefreshViewH
                    })
                }
            default:
                break
            }
        }
    }
    private func adjustStateWithContentOffset(scr: UIScrollView) {
        scrollView = scr
        if self.state != .Refreshing {
            
        }
        if self.state == .Refreshing {
            if scrollView.contentOffset.y >= -scrollViewInsetsDefaultValue.top{
                scrollViewInsets = scrollViewInsetsDefaultValue
            } else {
                scrollView.contentInset.top = min(scrollViewInsetsDefaultValue.top + frame.size.height, scrollViewInsetsDefaultValue.top - scrollView.contentOffset.y)
            }
            return
        }
        let offSetY = scrollView.contentOffset.y
        let happenOffsetY = -scrollViewInsetsDefaultValue.top
        if offSetY >= happenOffsetY { return }
        let normal2pullingOffsetY = happenOffsetY - RefreshViewH
        if scrollView.dragging {
            if self.state == .None && offSetY < normal2pullingOffsetY {
                self.state = .BeginRefresh
                println("BeginRefresh-----")
            } else if self.state == .BeginRefresh && offSetY >= normal2pullingOffsetY {
                self.state = .None
                println("None------------")
            }
        } else if self.state == .BeginRefresh && scrollView.dragging == false{
        self.state = .Refreshing
        println("Refreshing-------")
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.autoresizingMask = .FlexibleWidth
        self.backgroundColor = UIColor.clearColor()
        refreshLabel.frame = bounds
        refreshLabel.textAlignment = .Center
        refreshLabel.textColor = UIColor.grayColor()
        
        addSubview(refreshLabel)
    }
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func willMoveToSuperview(newSuperview: UIView!) {
        //        super.willMoveToSuperview(newSuperview)
        superview?.removeObserver(self, forKeyPath: KVO_KEYPATH, context: nil)
        if let asScrollView = newSuperview as? UIScrollView {
            asScrollView.addObserver(self, forKeyPath: KVO_KEYPATH, options: .Initial, context: nil)
            scrollView = asScrollView
            scrollViewInsetsDefaultValue = scrollView.contentInset
        }
    }
    deinit {
        var scroll = scrollView
        scroll?.removeObserver(self, forKeyPath: KVO_KEYPATH, context: nil)
        scroll = nil
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    func setTitle(title: String, forState: YKRefreshControlState) {
        switch forState {
        case .Refreshing:
            refreshLabel.text = title
        case .BeginRefresh,.None:
            refreshLabel.text = title
        }
    }
    public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [NSObject : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if let scr = object as? UIScrollView {
//            if self.state == .BeginRefresh || !self.userInteractionEnabled{
//                return
//            }
            if keyPath == KVO_KEYPATH {
                adjustStateWithContentOffset(scr)
            }
        }
    }
    func startRefreshing() {
        self.state = .Refreshing
    }
    func stopRefreshing() {
        self.state = .None
    }
}


