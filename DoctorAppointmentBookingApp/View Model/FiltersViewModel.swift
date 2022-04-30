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
    
    var doctorSearch = true
    
    static let shared = FiltersViewModel()
    
    var doctorViewModel = DoctorViewModel()
    var medicalCenterViewModel = MedicalCenterViewModel()
    
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
    
    private var allMedicalCenters = [MedicalCenter]() {
        didSet {
            DispatchQueue.main.async {
                self.medicalCenters = self.allMedicalCenters
            }
        }
    }

    var medicalCenters = [MedicalCenter]() {
        didSet {
            DispatchQueue.main.async {
//                self.medicalCenterCollectionView.reloadData()
//                print("4==> \(self.medicalCenters)")
            }
        }
    }
    
    let daysOfTheWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    private init() {
        loadData()
        print("doctorSearch = \(doctorSearch)")
    }
    
    func loadData() {
        doctorViewModel.getAllDoctors(collectionID: "doctors") { doctors in
                self.doctors = doctors
        }
        medicalCenterViewModel.getAllMedicalCenters(collectionID: "medicalCenters") { medicalCenters in
                self.medicalCenters = medicalCenters
        }

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
    
    func getWeekDaysList(startDate: Date, endDate: Date) -> [String]{
        var startDate = startDate // first date
        var weekDays: [String] = []
        
        while startDate.compare(endDate) != .orderedDescending {
            let index = Calendar.current.component(.weekday, from: startDate)
            //print("----> \(daysOfTheWeek[index-1])")
            weekDays.append(daysOfTheWeek[index-1])
            //print("----> \(weekDays)")
            startDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
        }
        
        return weekDays
        
//        print(getUniqueValues(list: weekDays))
//        let uniqueWeekDays = getUniqueValues(list: weekDays)
//        if doctorSearch == true {
//            getAvailableDoctors(weekDays: uniqueWeekDays)
//        } else {
//            //print("e cautare dupa centre medicale")
//            getAvailableMedicalCenters(weekDays: uniqueWeekDays)
//        }
        
       // print(doctors.count)
    }
    
    
    
    
    func getAvailableDoctors(startDate: Date, endDate: Date) -> [Doctor]{
        var weekDays = getWeekDaysList(startDate: startDate, endDate: endDate)
        let uniqueWeekDays = getUniqueValues(list: weekDays)
        
        var availableDoctors  = doctors
        var availableDoctorsOnMon: [Doctor] = []
        var availableDoctorsOnTue: [Doctor] = []
        var availableDoctorsOnWed: [Doctor] = []
        var availableDoctorsOnThu: [Doctor] = []
        var availableDoctorsOnFri: [Doctor] = []
        var availableDoctorsOnSat: [Doctor] = []
        var availableDoctorsOnSun: [Doctor] = []
        

        var set1 = Set(availableDoctors)
        
        if uniqueWeekDays.contains("Mon"){
            availableDoctorsOnMon = getDoctorsAvailableOnMon()
            let set2 = Set(availableDoctorsOnMon)
            //print("aici set2 \(set2))")
            set1 = set1.intersection(set2)
        }

        if uniqueWeekDays.contains("Tue"){
            availableDoctorsOnTue = getDoctorsAvailableOnTue()
            let set2 = Set(availableDoctorsOnTue)
            set1 = set1.intersection(set2)
        }
        if uniqueWeekDays.contains("Wed"){
            availableDoctorsOnWed = getDoctorsAvailableOnWed()
            let set2 = Set(availableDoctorsOnWed)
            set1 = set1.intersection(set2)
        }
        if uniqueWeekDays.contains("Thu"){
            availableDoctorsOnThu = getDoctorsAvailableOnThu()
            let set2 = Set(availableDoctorsOnThu)
            set1 = set1.intersection(set2)
        }
        if uniqueWeekDays.contains("Fri"){
            availableDoctorsOnFri = getDoctorsAvailableOnFri()
            let set2 = Set(availableDoctorsOnFri)
            set1 = set1.intersection(set2)
        }
        if uniqueWeekDays.contains("Sat"){
            availableDoctorsOnSat = getDoctorsAvailableOnSat()
            let set2 = Set(availableDoctorsOnSat)
            set1 = set1.intersection(set2)
        }
        if uniqueWeekDays.contains("Sun"){
            availableDoctorsOnSun = getDoctorsAvailableOnSun()
            let set2 = Set(availableDoctorsOnSun)
            set1 = set1.intersection(set2)
        }
        availableDoctors = Array(set1)
        print("----->>>>\(availableDoctors)")
        print(availableDoctors)
        
        return availableDoctors
    }
    
    func getAvailableMedicalCenters(startDate: Date, endDate: Date) -> [MedicalCenter] {
        
        var weekDays = getWeekDaysList(startDate: startDate, endDate: endDate)
        let uniqueWeekDays = getUniqueValues(list: weekDays)
        
        var availableMedicalCenters = medicalCenters
        var availableMedicalCentersOnMon: [MedicalCenter] = []
        var availableMedicalCentersOnTue: [MedicalCenter] = []
        var availableMedicalCentersOnWed: [MedicalCenter] = []
        var availableMedicalCentersOnThu: [MedicalCenter] = []
        var availableMedicalCentersOnFri: [MedicalCenter] = []
        var availableMedicalCentersOnSat: [MedicalCenter] = []
        var availableMedicalCentersOnSun: [MedicalCenter] = []
        
        var set1 = Set(availableMedicalCenters)

        if uniqueWeekDays.contains("Mon"){
            availableMedicalCentersOnMon = getMedicalCentersAvailableOnMon()
            let set2 = Set(availableMedicalCentersOnMon)
            //print("aici set2 \(set2))")
            set1 = set1.intersection(set2)
        }

        if uniqueWeekDays.contains("Tue"){
            availableMedicalCentersOnTue = getMedicalCentersAvailableOnTue()
            let set2 = Set(availableMedicalCentersOnTue)
            set1 = set1.intersection(set2)
        }
        if uniqueWeekDays.contains("Wed"){
            availableMedicalCentersOnWed = getMedicalCentersAvailableOnWed()
            let set2 = Set(availableMedicalCentersOnWed)
            set1 = set1.intersection(set2)
        }
        if uniqueWeekDays.contains("Thu"){
            availableMedicalCentersOnThu = getMedicalCentersAvailableOnThu()
            let set2 = Set(availableMedicalCentersOnThu)
            set1 = set1.intersection(set2)
        }
        if uniqueWeekDays.contains("Fri"){
            availableMedicalCentersOnFri = getMedicalCentersAvailableOnFri()
            let set2 = Set(availableMedicalCentersOnFri)
            set1 = set1.intersection(set2)
        }
        if uniqueWeekDays.contains("Sat"){
            availableMedicalCentersOnSat = getMedicalCentersAvailableOnSat()
            let set2 = Set(availableMedicalCentersOnSat)
            set1 = set1.intersection(set2)
        }
        if uniqueWeekDays.contains("Sun"){
            availableMedicalCentersOnSun = getMedicalCentersAvailableOnSun()
            let set2 = Set(availableMedicalCentersOnSun)
            set1 = set1.intersection(set2)
        }
        availableMedicalCenters = Array(set1)
        print("MedicalCenters----->>>>\(availableMedicalCenters)")
        print(availableMedicalCenters)
        
        return availableMedicalCenters
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
    
    
    func getMedicalCentersAvailableOnMon() -> [MedicalCenter] {
        var availableMedicalCentersOnMon: [MedicalCenter] = []
        for medicalCenter in medicalCenters {
            if medicalCenter.mon != "" {
                availableMedicalCentersOnMon.append(medicalCenter)
            }
        }
        
        return availableMedicalCentersOnMon
    }
    
    func getMedicalCentersAvailableOnTue() -> [MedicalCenter] {
        var availableMedicalCentersOnTue: [MedicalCenter] = []
        for medicalCenter in medicalCenters {
            if medicalCenter.tue != "" {
                availableMedicalCentersOnTue.append(medicalCenter)
            }
        }
        
        return availableMedicalCentersOnTue
    }
    
    
    func getMedicalCentersAvailableOnWed() -> [MedicalCenter] {
        var availableMedicalCentersOnWed: [MedicalCenter] = []
        for medicalCenter in medicalCenters {
            if medicalCenter.wed != "" {
                availableMedicalCentersOnWed.append(medicalCenter)
            }
        }
        
        return availableMedicalCentersOnWed
    }
    
    func getMedicalCentersAvailableOnThu() -> [MedicalCenter] {
        var availableMedicalCentersOnThu: [MedicalCenter] = []
        for medicalCenter in medicalCenters {
            if medicalCenter.thu != "" {
                availableMedicalCentersOnThu.append(medicalCenter)
            }
        }
        
        return availableMedicalCentersOnThu
    }
    
    func getMedicalCentersAvailableOnFri() -> [MedicalCenter] {
        var availableMedicalCentersOnFri: [MedicalCenter] = []
        for medicalCenter in medicalCenters {
            if medicalCenter.fri != "" {
                availableMedicalCentersOnFri.append(medicalCenter)
            }
        }
        
        return availableMedicalCentersOnFri
    }
    
    func getMedicalCentersAvailableOnSat() -> [MedicalCenter] {
        var availableMedicalCentersOnSat: [MedicalCenter] = []
        for medicalCenter in medicalCenters {
            if medicalCenter.sat != "" {
                availableMedicalCentersOnSat.append(medicalCenter)
            }
        }
        
        return availableMedicalCentersOnSat
    }
    
    func getMedicalCentersAvailableOnSun() -> [MedicalCenter] {
        var availableMedicalCentersOnSun: [MedicalCenter] = []
        for medicalCenter in medicalCenters {
            if medicalCenter.sun != "" {
                availableMedicalCentersOnSun.append(medicalCenter)
            }
        }
        
        return availableMedicalCentersOnSun
    }
    
//
//    func getDoctorsBy(service: String) -> [Doctor] {
//        var result: [Doctor] = []
//        for doctor in doctors {
//            if doctor.service == service {
//                result.append(doctor)
//            }
//        }
//
//        print("[][][][]  \(result)")
//        return result
//    }
    
    func getDoctorsByServiceWorkingAt(service: String, medicalCenterName: String) -> [Doctor] {
        var result: [Doctor] = []
        for doctor in doctors {
            let worksAt = doctor.worksAt.components(separatedBy: ",")
            if worksAt.contains(medicalCenterName) {
                if doctor.service == service {
                    result.append(doctor)
                }
            }
        }
        
        print("[][][][]  \(result)")
        return result
    }
    
    
//
//    func getDoctorsWorkingAt(medicalCenterName: String) -> [Doctor] {
//        var result: [Doctor] = []
//        for doctor in doctors {
//            let worksAt = doctor.worksAt.components(separatedBy: ",")
//
//            if worksAt.contains(medicalCenterName){
//                result.append(doctor)
//            }
//        }
//
//        print("[][][][]  \(result)")
//        return result
//    }
}


