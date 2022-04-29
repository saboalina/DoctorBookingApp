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
    
    var medicalCenter: MedicalCenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLabels()
    }
    
    func setLabels() {
        nameLabel.text = medicalCenter.name
        addressLabel.text = medicalCenter.address
        monProgramLabel.text = medicalCenter.mon
        tueProgramLabel.text = medicalCenter.tue
        wedProgramLabel.text = medicalCenter.wed
        thuProgramLabel.text = medicalCenter.thu
        friProgramLabel.text = medicalCenter.fri
        satProgramLabel.text = medicalCenter.sat
        sunProgramLabel.text = medicalCenter.sun

    }


}
