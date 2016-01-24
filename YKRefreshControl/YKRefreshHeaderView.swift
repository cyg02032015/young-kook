//
//  YKRefreshHeaderView.swift
//  YKRefreshControl
//
//  Created by C on 15/7/29.
//  Copyright (c) 2015年 SK. All rights reserved.
//

import UIKit
enum YKRefreshControlState : Int{
    case BeginRefresh = 0
    case Refreshing
    case None
}
public class YKRefreshHeaderView: YKRefreshView {
    public var refreshLabel = UILabel()
    public var action: ()->() = {}
    private var headerPercent: CGFloat!
    private var state: YKRefreshControlState = .None{
        
        didSet {
            if oldValue == state {return}
            switch state {
            case .Refreshing:
                UIView.animateWithDuration(0.5, delay: 0.0, options: [.AllowUserInteraction,.BeginFromCurrentState], animations: { () -> Void in
                    let top = self.scrollViewInsetsDefaultValue.top + RefreshViewH;
                    self.scrollView.contentInset.top = top;
                    self.scrollView.contentOffset.y = -top;
                    self.setTitle("正在刷新...", forState: YKRefreshControlState.Refreshing)
                    }, completion: { (finish) -> Void in
//                        if self.action != nil {
                            self.action()
//                        }
                })
                break
            case .BeginRefresh:
                setTitle("松手就刷新", forState: YKRefreshControlState.BeginRefresh)
            case .None:
                if oldValue == .BeginRefresh {
                    setTitle("Pull To Refresh", forState: YKRefreshControlState.None)
                }else if oldValue == .Refreshing {
                    UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                        self.setTitle("刷新完成", forState: YKRefreshControlState.None)
                        self.scrollView.contentInset.top -= RefreshViewH
                        }, completion: { (finish) -> Void in
                            self.setTitle("Pull To Refresh", forState: YKRefreshControlState.None)
                            //                            self.scrollView.contentInset.top += RefreshViewH
                    })
                }
            default:
                break
            }
        }
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        refreshLabel.frame = bounds
        refreshLabel.textAlignment = .Center
        refreshLabel.textColor = UIColor.blackColor()
        addSubview(refreshLabel)
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func adjustStateWithContentOffset() {
//        if self.state != .Refreshing {
//            
//        }
        if self.state == .Refreshing {
            if scrollView.contentOffset.y >= -scrollViewInsetsDefaultValue.top{
                scrollViewInsets = scrollViewInsetsDefaultValue
            } else {
                scrollView.contentInset.top = min(scrollViewInsetsDefaultValue.top + RefreshViewH, scrollViewInsetsDefaultValue.top - scrollView.contentOffset.y)
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
            } else if self.state == .BeginRefresh && offSetY >= normal2pullingOffsetY {
                self.state = .None
            }
        } else if self.state == .BeginRefresh && scrollView.dragging == false{
            self.state = .Refreshing
        }
    }
    func setTitle(title: String, forState: YKRefreshControlState) {
        switch forState {
        case .Refreshing:
            refreshLabel.text = title
        case .BeginRefresh:
            refreshLabel.text = title
        case .None:
            refreshLabel.text = title
        }
    }
    //MARK: KVO监听
  public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    if let scr = object as? UIScrollView {
      if self.state == .Refreshing {
        return
      }
      if keyPath == KVO_CONTENTOFFSET {
        adjustStateWithContentOffset()
      }
    }
  }

    public override func startRefreshing() {
        self.state = .Refreshing
    }
    public override func stopRefreshing() {
        self.state = .None
    }
}
