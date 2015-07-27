//
//  GCDDelay.swift
//  Demo
//
//  Created by C on 15/7/8.
//  Copyright (c) 2015年 SK. All rights reserved.
//

import UIKit

typealias Task = (cancel: Bool) -> ()

  func delay(time: NSTimeInterval, task:() -> ()) -> Task?{
    func dispatch_later(block: () -> ()){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), block)
    }
    var closure: dispatch_block_t? = task
    var result: Task?
    let delayClosure: Task = {
        cancel in
        if let internalClosure = closure {
            if cancel == false {
                dispatch_async(dispatch_get_main_queue(), internalClosure)
            }
        }
        closure = nil
        result = nil
    }
    result = delayClosure
    
    dispatch_later { () -> () in
        if let delayClosure = result {
            delayClosure(cancel: false)
        }
    }
    return result
}
func cancel(task: Task?){
    task?(cancel: true)
}


extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRectMake(0, 0, 1, 1)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}