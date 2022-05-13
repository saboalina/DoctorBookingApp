
import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var viewUiView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewUiView.layer.cornerRadius = 5
        viewUiView.backgroundColor = Colors.brown

        viewUiView.layer.shadowColor = UIColor.black.cgColor
        viewUiView.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewUiView.layer.shadowOpacity = 0.7
        viewUiView.layer.shadowRadius = 4.0
    }

    @IBAction func logInButtonTapped(_ sender: Any) {
        
        let logInPage = storyboard?.instantiateViewController(withIdentifier: "LoginPage") as? LoginViewController
     
//        view.window?.rootViewController = loginPage
//        view.window?.makeKeyAndVisible()
        navigationController?.pushViewController(logInPage!, animated: true)
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        let signUpPage = storyboard?.instantiateViewController(withIdentifier: "SignUpPage") as? SignUpViewController
     
//        view.window?.rootViewController = loginPage
//        view.window?.makeKeyAndVisible()
        navigationController?.pushViewController(signUpPage!, animated: true)
    }
    
}

