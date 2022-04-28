//
//  FiltersViewModel.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 28.04.2022.
//

import Foundation


class FiltersViewModel {
    
    var startDate: Date!
    var endDate: Date!
    
    static let shared = FiltersViewModel()
    
    var doctorViewModel = DoctorViewModel()
    
    private var allDoctors = [Doctor]() {
        didSet {
            DispatchQueue.main.async {
                self.doctors = self.allDoctors
            }
        }
    }

    var doctors = [Doctor]() {
        didSet {
            DispatchQueue.main.async {
//                self.doctorCollectionView.reloadData()
            }
        }
    }
    
    
    
    private init() {
        loadData()
    }
    
    func loadData() {
        doctorViewModel.getAllDoctors(collectionID: "doctors") { doctors in
                self.doctors = doctors
        }
        //print("2==> \(doctors)")
        
//        medicalCenterViewModel.getAllMedicalCenters(collectionID: "medicalCenters") { medicalCenters in
//                self.medicalCenters = medicalCenters
//        }

    }
    
    func getWeekDaysList() {

    }
    
    func filterDoctorsBy() {
        
    }
    
}

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return numberOfDays.day!
    }
}
