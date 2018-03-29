//
//  VTPopupBaseView.swift
//  SDToastToolDemo
//
//  Created by pangxiang on 3/22/18.
//  Copyright © 2018 pangxiang. All rights reserved.
//

import UIKit

class VTPopupBaseView: UIView {
    private var contentView: UIView!
    private var backgroundView: UIView!
    private var dissMissWithBackgroudTouch:Bool!
    private var dismissFinishCallback:ClearClosure?
    private static let instance = VTPopupBaseView.init(frame: UIScreen.main.bounds)
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor.clear
        
        dissMissWithBackgroudTouch = true
        backgroundView = UIView.init(frame: frame)
        backgroundView.isUserInteractionEnabled = false
        backgroundView.backgroundColor = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
        
        self.addSubview(backgroundView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    ///获取单例
    class func shared() -> VTPopupBaseView{
        return instance
    }
    
    // MARK: - Class Public
    func showPopupView(contentView:UIView,bgTouchDismiss:Bool){
        self.contentView = contentView
        self.dissMissWithBackgroudTouch = bgTouchDismiss
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDismiss(notification:)), name: .UIKeyboardWillHide, object: nil)
        
        self.show()
    }
        
    func dismissPopupView(withCallback callback:ClearClosure?){
        dismissFinishCallback = callback
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
        
        self.dissmiss()
    }
    
    // MARK: - Class Private
    private func show(){
        let mainQueue = DispatchQueue.main
        mainQueue.async {
            if self.superview == nil{
                let reverseWindows = UIApplication.shared.windows.reversed()
                for window in reverseWindows{
                    if window.windowLevel == UIWindowLevelNormal{
                        window.addSubview(self)
                        break
                    }
                }
            }
            if self.contentView.superview != self{
                self.contentView.center = self.center
                self.addSubview(self.contentView)
            }
        }
    }
    
    private func dissmiss(){
        let mainQueue = DispatchQueue.main
        mainQueue.async {
            if self.contentView != nil{
                self.contentView.removeFromSuperview()
            }
            self.removeFromSuperview()
            self.dissMissWithBackgroudTouch = true
            if let callback = self.dismissFinishCallback{
               callback()
            }
        }
    }
    
    // MARK: - KeyBoardCallback
    @objc private func keyBoardShow(notification: Notification) {
        let kbInfo = notification.userInfo
        let duration = kbInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        let kbRect = (kbInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        if contentView.sdHeight + contentView.sdY + kbRect.size.height > UIScreen.main.bounds.size.height {
            UIView.animate(withDuration: duration) {
                let contentCenterY = (UIScreen.main.bounds.size.height - kbRect.size.height)/2
                self.contentView?.center = CGPoint.init(x: self.backgroundView.center.x, y: contentCenterY)
            }
        }
    }
    
    @objc private func keyBoardDismiss(notification: Notification) {
        let kbInfo = notification.userInfo
        let duration = kbInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: duration) {
            self.contentView.center = self.backgroundView.center
        }
    }
    
    // MARK: - UIView
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view == self {
            if dissMissWithBackgroudTouch{
                self.dismissPopupView(withCallback: nil)
            }
        }
        return view
    }
}
// MARK: - 
extension UIView {
    // XIB绑定的名字必须和类名字一样
    class func loadFromXIB() -> UIView {
        
        let classNameCopy = NSStringFromClass(self.classForCoder())
        let name = classNameCopy.components(separatedBy: ".").last
        
        let nibView = Bundle.main.loadNibNamed(name!, owner: self, options: nil)!.first
        return nibView as! UIView
    }
    
    var sdWidth: CGFloat {
        get{
            return self.frame.size.width
        }
        set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    var sdHeight: CGFloat {
        get{
            return self.frame.size.height
        }
        set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    var sdX: CGFloat {
        get{
            return self.frame.origin.x
        }
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    var sdY: CGFloat {
        get{
            return self.frame.origin.y
        }
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    var sdSize: CGSize {
        get{
            return self.frame.size
        }
        set{
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    
}
