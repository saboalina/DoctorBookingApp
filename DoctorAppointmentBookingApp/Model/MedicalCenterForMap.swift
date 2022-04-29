//
//  MedicalCenterForMap.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 29.04.2022.
//

import Foundation
import MapKit

class MedicalCenterForMap: NSObject, MKAnnotation {
   
    let locationName: String?
    let coordinate: CLLocationCoordinate2D

    init(
      locationName: String?,
      coordinate: CLLocationCoordinate2D
    ) {

      self.locationName = locationName
      self.coordinate = coordinate

      super.init()
    }
}
