

import Foundation
import UIKit

class ViewDesign: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = Colors.darkBlue
        
        layer.cornerRadius = 10
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 4.0
        
        clipsToBounds = false;
        layer.masksToBounds = false;
        
    }
}
