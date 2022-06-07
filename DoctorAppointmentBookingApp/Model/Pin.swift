
import Foundation
import MapKit

class Pin: MKPinAnnotationView
{
    
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

    }
    
    func setLabel(text: String) {
        
        let selectedLabel:UILabel = UILabel.init(frame:CGRect(x: 0, y: 0, width: 100, height: 25))
        
        selectedLabel.text = text
        selectedLabel.textAlignment = .center
        selectedLabel.font = UIFont.init(name: "HelveticaBold", size: 7)
        selectedLabel.backgroundColor = UIColor.white
        selectedLabel.layer.borderColor = UIColor.gray.cgColor
        selectedLabel.layer.borderWidth = 1
        selectedLabel.layer.cornerRadius = 5
        selectedLabel.layer.masksToBounds = true

        selectedLabel.center.x = 0.5 * self.frame.size.width;
        selectedLabel.center.y = -0.5 * selectedLabel.frame.height;
        self.addSubview(selectedLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
