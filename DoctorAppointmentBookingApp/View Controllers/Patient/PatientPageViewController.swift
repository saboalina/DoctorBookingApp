

import UIKit

class PatientPageViewController: UITabBarController, UITabBarControllerDelegate {
    
    var patient: Patient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        guard let viewControllers = viewControllers else { return }
        
        for viewController in viewControllers {
            
            if let patientHomeNavigationController = viewController as? PatientHomeNavigationController{
                if let patientHomeViewController = patientHomeNavigationController.viewControllers.first as? PatientHomeViewController {
                    patientHomeViewController.patient = patient!
                }
            }
            
            if let patientAppointmentsNavigationController = viewController as? PatientAppointmentsNavigationController{
                if let patientAppointmentsViewController = patientAppointmentsNavigationController.viewControllers.first as? PatientAppointmentsViewController {
                    patientAppointmentsViewController.patient = patient!
                }
            }
            
            if let patientMapNavigationController = viewController as? PatientMapNavigationController{
                if let patientMapViewController = patientMapNavigationController.viewControllers.first as? PatientMapViewController {
                    patientMapViewController.patient = patient!
                }
            }
            
            if let patientProfileNavigationController = viewController as? PatientProfileNavigationController{
                if let patientProfileViewController = patientProfileNavigationController.viewControllers.first as? PatientProfileViewController {
                    patientProfileViewController.patient = patient!
                }
            }
        }
    }

}
