//
//  PatientHomeViewController.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 23.04.2022.
//

import UIKit
import Firebase

class PatientHomeViewController: UIViewController {
    
    
    @IBOutlet weak var doctorCollectionView: UICollectionView!
    @IBOutlet weak var medicalCenterCollectionView: UICollectionView!
    
    var doctorViewModel = DoctorViewModel()
    var medicalCenterViewModel = MedicalCenterViewModel()
    
    private var allDoctors = [Doctor]() {
        didSet {
            DispatchQueue.main.async {
                self.doctors = self.allDoctors
                //print("3==> \(self.doctors)")
            }
        }
    }

    var doctors = [Doctor]() {
        didSet {
            DispatchQueue.main.async {
                self.doctorCollectionView.reloadData()
                //print("4==> \(self.doctors)")
            }
        }
    }
    
    private var allMedicalCenters = [MedicalCenter]() {
        didSet {
            DispatchQueue.main.async {
                self.medicalCenters = self.allMedicalCenters
                print("3==> \(self.medicalCenters)")
            }
        }
    }

    var medicalCenters = [MedicalCenter]() {
        didSet {
            DispatchQueue.main.async {
                //self.medicalCenterCollectionView.reloadData()
                print("4==> \(self.medicalCenters)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        registerCell()
    }

    func loadData() {
        doctorViewModel.getAllDoctors(collectionID: "doctors") { doctors in
                self.doctors = doctors
        }
        print("2==> \(doctors)")
        
        medicalCenterViewModel.getAllMedicalCenters(collectionID: "medicalCenters") { medicalCenters in
                self.medicalCenters = medicalCenters
        }

    }
    
    private func registerCell() {
        doctorCollectionView.register(
            UINib(nibName: DoctorHorizontalViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DoctorHorizontalViewCell.identifier)
    }
}

extension PatientHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doctors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoctorHorizontalViewCell.identifier, for: indexPath) as! DoctorHorizontalViewCell
        cell.setup(doctor: doctors[indexPath.row])
        return cell
    }
    
    
}
