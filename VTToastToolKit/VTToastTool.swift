//
//  VTToastTool.swift
//  VTToastToolDemo
//
//  Created by pangxiang on 3/23/18.
//  Copyright © 2018 pangxiang. All rights reserved.
//

import UIKit
public typealias ClearClosure = ()->Void

public class VTToastTool: NSObject {
    /**
     通过VTPopupBaseView单例展示指定视图
     - parameter contenView:  需要展示的视图
     - returns:    Void
     */
   public class func showPopupView(withContentView contentView:UIView){
        VTToastTool.showPopupView(withContentView: contentView, andDissmissWithBackgroundTouch: true)
    }
    
    /**
     通过VTPopupBaseView单例展示指定视图
     
     - parameter contenView:  需要展示的视图
     - parameter dissmissWithBackgroundTouch:  点击背景是否dismiss
     - returns:    Void
     */
   public class func showPopupView(withContentView contentView:UIView,andDissmissWithBackgroundTouch bgTouchDismiss:Bool){
        let popupView = VTPopupBaseView.shared()
        popupView.showPopupView(contentView: contentView, bgTouchDismiss: bgTouchDismiss)
    }
    
    /**
     将VTPopupBaseView单例从window上移除
     - returns:    Void
     */
   public class func dissmissPopupView(){
        VTToastTool.dissmissPopupViewWithCallback(callback: nil)
    }
    
    /**
     将VTPopupBaseView单例从window上移除
     - returns:    Void
     */
   public class func dissmissPopupViewWithCallback(callback:ClearClosure?){
        let popupView = VTPopupBaseView.shared()
        popupView.dismissPopupView(withCallback: callback)
        
    }


}
