
import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var viewUiView: UIView!
    @IBOutlet weak var titleUiView: ViewDesign!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewUiView.layer.cornerRadius = 10
        viewUiView.backgroundColor = Colors.brown

        viewUiView.layer.shadowColor = UIColor.black.cgColor
        viewUiView.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewUiView.layer.shadowOpacity = 0.7
        viewUiView.layer.shadowRadius = 4.0
        
        
        titleUiView.layer.cornerRadius = 10
        titleUiView.backgroundColor = Colors.brown

        titleUiView.layer.shadowColor = UIColor.black.cgColor
        titleUiView.layer.shadowOffset = CGSize(width: 3, height: 3)
        titleUiView.layer.shadowOpacity = 0.7
        titleUiView.layer.shadowRadius = 4.0
        
        titleLabel.textColor = UIColor(red: 33/255, green: 108/255, blue: 130/255, alpha: 1)
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowOffset = CGSize(width: 3, height: 3)
        titleLabel.layer.shadowOpacity = 0.3
        titleLabel.layer.shadowRadius = 4.0
    }

    @IBAction func logInButtonTapped(_ sender: Any) {
        
        let logInPage = storyboard?.instantiateViewController(withIdentifier: "LoginPage") as? LoginViewController
     
        navigationController?.pushViewController(logInPage!, animated: true)
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        let signUpPage = storyboard?.instantiateViewController(withIdentifier: "SignUpPage") as? SignUpViewController
     
        navigationController?.pushViewController(signUpPage!, animated: true)
    }
    
}

