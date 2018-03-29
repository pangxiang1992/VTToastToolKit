//

import UIKit
import VTToastToolKit
class CartAlertView: UIView {

    class func sharedInstance() -> CartAlertView {
        let hintView = CartAlertView.loadFromXIB() as! CartAlertView
        let attributedString = NSMutableAttributedString.init(string: "确认是否提交订单\n\n（提交后商品不可更改!）")
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSMakeRange(8, 14))
        hintView.nameLable.attributedText =  attributedString
        return hintView
    }
    @IBAction func canclebtn() {
        //SDToastTool.dissmissPopupView()
        VTToastTool.dissmissWithCallback {
            print("cancleBtn")
        }
    }
    
    @IBOutlet weak var cancleBtn: UIButton!
    @IBOutlet weak var surebtn: UIButton!
    @IBAction func sureBtn() {
        //SDToastTool.dissmissPopupView()
        VTToastTool.dissmissWithCallback {
            print("sureBtn")
        }
    }
    @IBOutlet weak var nameLable: UILabel!
}
