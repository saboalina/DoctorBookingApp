//
//  Error.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 14.04.2022.
//

import Foundation

enum DoctorError: Error {
     
    case UserNotFound
}

enum PatientError: Error {
     
    case UserNotFound
}

enum AppointmentError: Error {
    case AppointmentNotFound
}

enum MedicalCenterError: Error {
    case MedicalCenterNotFound
}


