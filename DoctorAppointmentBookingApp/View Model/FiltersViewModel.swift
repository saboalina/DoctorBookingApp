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
    
    let daysOfTheWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
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
    
    func getUniqueValues(list: [String]) -> [String] {
        var uniqueValues: [String] = []
        
        for elem in list {
            if !uniqueValues.contains(elem) {
                uniqueValues.append(elem)
            }
        }
        
        return uniqueValues
    }
    
    func getWeekDaysList(startDate: Date, endDate: Date) {
        var startDate = startDate // first date
        var weekDays: [String] = []
        
        while startDate.compare(endDate) != .orderedDescending {
            let index = Calendar.current.component(.weekday, from: startDate)
            //print("----> \(daysOfTheWeek[index-1])")
            weekDays.append(daysOfTheWeek[index-1])
            //print("----> \(weekDays)")
            startDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
        }
        
        print(getUniqueValues(list: weekDays))
        let uniqueWeekDays = getUniqueValues(list: weekDays)
        getAvailableDoctors(weekDays: uniqueWeekDays)
       // print(doctors.count)
    }
    
    
    func getAvailableDoctors(weekDays: [String]) {
        var availableDoctors  = doctors
        var availableDoctorsOnMon: [Doctor] = []
        var availableDoctorsOnTue: [Doctor] = []
        var availableDoctorsOnWed: [Doctor] = []
        var availableDoctorsOnThu: [Doctor] = []
        var availableDoctorsOnFri: [Doctor] = []
        var availableDoctorsOnSat: [Doctor] = []
        var availableDoctorsOnSun: [Doctor] = []
        

        var set1 = Set(availableDoctors)
//
//        print("aici set1 \(set1))")
        
        if weekDays.contains("Mon"){
            availableDoctorsOnMon = getDoctorsAvailableOnMon()
            let set2 = Set(availableDoctorsOnMon)
            //print("aici set2 \(set2))")
            set1 = set1.intersection(set2)
        }
        
//        print("aici set1 \(set1)")
//
//
        if weekDays.contains("Tue"){
            availableDoctorsOnTue = getDoctorsAvailableOnTue()
            let set2 = Set(availableDoctorsOnTue)
            set1 = set1.intersection(set2)
        }
        if weekDays.contains("Wed"){
            availableDoctorsOnWed = getDoctorsAvailableOnWed()
            let set2 = Set(availableDoctorsOnWed)
            set1 = set1.intersection(set2)
        }
        if weekDays.contains("Thu"){
            availableDoctorsOnThu = getDoctorsAvailableOnThu()
            let set2 = Set(availableDoctorsOnThu)
            set1 = set1.intersection(set2)
        }
        if weekDays.contains("Fri"){
            availableDoctorsOnFri = getDoctorsAvailableOnFri()
            let set2 = Set(availableDoctorsOnFri)
            set1 = set1.intersection(set2)
        }
        if weekDays.contains("Sat"){
            availableDoctorsOnSat = getDoctorsAvailableOnSat()
            let set2 = Set(availableDoctorsOnSat)
            set1 = set1.intersection(set2)
        }
        if weekDays.contains("Sun"){
            availableDoctorsOnSun = getDoctorsAvailableOnSun()
            let set2 = Set(availableDoctorsOnSun)
            set1 = set1.intersection(set2)
        }
        availableDoctors = Array(set1)
        print("----->>>>\(availableDoctors)")
        print(availableDoctors)
    }
    
    func getDoctorsAvailableOnMon() -> [Doctor] {
        var availableDoctorsOnMon: [Doctor] = []
        for doctor in doctors {
            if doctor.mon != "" {
                availableDoctorsOnMon.append(doctor)
            }
        }
        
        return availableDoctorsOnMon
    }
    
    func getDoctorsAvailableOnTue() -> [Doctor] {
        var availableDoctorsOnTue: [Doctor] = []
        for doctor in doctors {
            if doctor.tue != "" {
                availableDoctorsOnTue.append(doctor)
            }
        }
        
        return availableDoctorsOnTue
    }
    
    
    func getDoctorsAvailableOnWed() -> [Doctor] {
        var availableDoctorsOnWed: [Doctor] = []
        for doctor in doctors {
            if doctor.wed != "" {
                availableDoctorsOnWed.append(doctor)
            }
        }
        
        return availableDoctorsOnWed
    }
    
    func getDoctorsAvailableOnThu() -> [Doctor] {
        var availableDoctorsOnThu: [Doctor] = []
        for doctor in doctors {
            if doctor.thu != "" {
                availableDoctorsOnThu.append(doctor)
            }
        }
        
        return availableDoctorsOnThu
    }
    
    func getDoctorsAvailableOnFri() -> [Doctor] {
        var availableDoctorsOnFri: [Doctor] = []
        for doctor in doctors {
            if doctor.fri != "" {
                availableDoctorsOnFri.append(doctor)
            }
        }
        
        return availableDoctorsOnFri
    }
    
    func getDoctorsAvailableOnSat() -> [Doctor] {
        var availableDoctorsOnSat: [Doctor] = []
        for doctor in doctors {
            if doctor.sat != "" {
                availableDoctorsOnSat.append(doctor)
            }
        }
        
        return availableDoctorsOnSat
    }
    
    func getDoctorsAvailableOnSun() -> [Doctor] {
        var availableDoctorsOnSun: [Doctor] = []
        for doctor in doctors {
            if doctor.sun != "" {
                availableDoctorsOnSun.append(doctor)
            }
        }
        
        return availableDoctorsOnSun
    }
    

}


