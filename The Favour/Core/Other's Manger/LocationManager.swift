//
//  LocationManager.swift
//  The Favour
//
//  Created by Atta khan on 14/07/2023.
//

import SwiftUI
import Combine
import CoreLocation


class LocationManager: NSObject, ObservableObject {

    private let locationManager = CLLocationManager()
    @Published var currentLocation: CLLocation?
    @Published var currentAddress: String = ""
    @Published var markerPosition: CLLocationCoordinate2D = kCLLocationCoordinate2DInvalid
    @Published var presentSheet = false

    @Published var location: CLLocation? {
       willSet { objectWillChange.send() }
    }
    
    var latitude: CLLocationDegrees {
        return location?.coordinate.latitude ?? 0
    }
    
    var longitude: CLLocationDegrees {
        return location?.coordinate.longitude ?? 0
    }
    private var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

        locationManager.requestWhenInUseAuthorization()
        
        $currentLocation
            .sink { [weak self] location in
                guard let location = location else { return }
                self?.reverseGeocode(location: location)
            }
            .store(in: &cancellables)
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func reverseGeocode(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard error == nil, let placemark = placemarks?.first else { return }
            
            var address = ""

            if let subThoroughfare = placemark.subThoroughfare {
                address += subThoroughfare + " "
            }

            if let thoroughfare = placemark.thoroughfare {
                address += thoroughfare + ", "
            }

            if let locality = placemark.locality {
                address += locality + ", "
            }

            if let administrativeArea = placemark.administrativeArea {
                address += administrativeArea + ", "
            }

            if let postalCode = placemark.postalCode {
                address += postalCode + ", "
            }

            if let country = placemark.country {
                address += country
            }

            self.currentAddress = address
        

        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        currentLocation = location
        markerPosition = location.coordinate
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
    }
}
