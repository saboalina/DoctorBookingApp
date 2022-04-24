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
    
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    
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
                self.medicalCenterCollectionView.reloadData()
                print("4==> \(self.medicalCenters)")
            }
        }
    }
    
    let categories = ["Dermathology", "Endocrinology", "Ultrasound", "Dermathology", "Psychology", "Plastic surgery",
                      "Nutrition", "Cardiology", "Ophthalmology", "Neurology", "Paediatrics", "Psychiatry"]
    
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
        
        categoriesCollectionView.register(
            UINib(nibName: CategoriesViewCell.identifier, bundle: nil), forCellWithReuseIdentifier:
                CategoriesViewCell.identifier)
        
        
        medicalCenterCollectionView.register(
            UINib(nibName: MedicalCenterHorizontalViewCell.identifier, bundle: nil), forCellWithReuseIdentifier:
                MedicalCenterHorizontalViewCell.identifier)
        
        
    }
}

extension PatientHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.doctorCollectionView {
            return doctors.count
        }
        if collectionView == self.categoriesCollectionView {
            return categories.count
        }
        return medicalCenters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.doctorCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoctorHorizontalViewCell.identifier, for: indexPath) as! DoctorHorizontalViewCell
            cell.setup(doctor: doctors[indexPath.row])
            return cell
        }
        if collectionView == self.categoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesViewCell.identifier, for: indexPath) as! CategoriesViewCell
            cell.setup(category: categories[indexPath.row])
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedicalCenterHorizontalViewCell.identifier, for: indexPath) as! MedicalCenterHorizontalViewCell
        cell.setup(medicalCenter: medicalCenters[indexPath.row])
        return cell
    }
    
    
}
