
import Foundation
import UIKit

class ButtonClassBlue: UIButton{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = frame.height/5
        backgroundColor = UIColor(red: 81/255, green: 152/255, blue: 180/255, alpha: 1.0)
        tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
//        backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alp
        //titleColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        //backgroundColor =
        //tintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
    }
}

