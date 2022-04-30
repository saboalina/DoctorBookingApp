//
//  PatientMedicalCentreDetailsViewController.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 29.04.2022.
//

import UIKit

class PatientMedicalCenterDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var monProgramLabel: UILabel!
    @IBOutlet weak var tueProgramLabel: UILabel!
    @IBOutlet weak var wedProgramLabel: UILabel!
    @IBOutlet weak var thuProgramLabel: UILabel!
    @IBOutlet weak var friProgramLabel: UILabel!
    @IBOutlet weak var satProgramLabel: UILabel!
    @IBOutlet weak var sunProgramLabel: UILabel!
    @IBOutlet weak var servicesTableView: UITableView!
    
    var medicalCenter: MedicalCenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let services = medicalCenter.services.components(separatedBy: ",")
        print("]]]]]]] \(services)")
        setLabels()
    }
    
    func setLabels() {
        nameLabel.text = medicalCenter.name
        addressLabel.text = medicalCenter.address
        if medicalCenter.mon == "" {
            monProgramLabel.text = "Closed"
        } else {
            monProgramLabel.text = medicalCenter.mon
        }
        
        if medicalCenter.tue == "" {
            tueProgramLabel.text = "Closed"
        } else {
            tueProgramLabel.text = medicalCenter.tue
        }
        
        if medicalCenter.wed == "" {
            wedProgramLabel.text = "Closed"
        } else {
            wedProgramLabel.text = medicalCenter.wed
        }
        
        if medicalCenter.thu == "" {
            thuProgramLabel.text = "Closed"
        } else {
            thuProgramLabel.text = medicalCenter.thu
        }
        
        if medicalCenter.fri == "" {
            friProgramLabel.text = "Closed"
        } else {
            friProgramLabel.text = medicalCenter.fri
        }
        
        if medicalCenter.sat == "" {
            satProgramLabel.text = "Closed"
        } else {
            satProgramLabel.text = medicalCenter.sat
        }
        
        if medicalCenter.sun == "" {
            sunProgramLabel.text = "Closed"
        } else {
            sunProgramLabel.text = medicalCenter.sun
        }

    }


}
