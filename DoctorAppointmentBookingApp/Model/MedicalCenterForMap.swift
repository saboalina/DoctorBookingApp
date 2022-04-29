//
//  MedicalCenterForMap.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 29.04.2022.
//

import Foundation
import MapKit

class MedicalCenterForMap: NSObject, MKAnnotation {
   
    let title: String?
    let coordinate: CLLocationCoordinate2D

    init(title: String?, coordinate: CLLocationCoordinate2D) {

        self.title = title
        self.coordinate = coordinate
        

        super.init()
    }
}
