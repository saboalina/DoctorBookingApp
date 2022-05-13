
import Foundation
import UIKit

class ButtonClassBlue: UIButton{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = frame.height/5
        backgroundColor = Colors.blue
        tintColor = Colors.white

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 4.0
        
    }
}

