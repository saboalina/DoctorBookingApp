
import Foundation
import UIKit

class ButtonClassOrange: UIButton{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = frame.height/5
        backgroundColor = UIColor(red: 253/255, green: 136/255, blue: 83/255, alpha: 1.0)
        tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 4.0
    }
}