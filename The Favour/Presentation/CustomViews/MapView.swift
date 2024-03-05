//
//  MapView.swift
//  The Favour
//
//  Created by Atta khan on 27/07/2023.
//

import SwiftUI
import GoogleMaps
import CoreLocation


struct MapView: UIViewRepresentable {
    @State private var marker: GMSMarker? // Store the marker as a property
    @ObservedObject var locationManager: LocationManager
    @ObservedObject var viewModel: FavorViewModel
    @Binding var isPresented: Bool
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: locationManager.latitude, longitude: locationManager.longitude, zoom: 12.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ mapView: GMSMapView, context: Context) {
        if viewModel.favors == nil {
            if context.coordinator.marker == nil {
                context.coordinator.marker = GMSMarker()
                context.coordinator.marker?.isDraggable = true
                context.coordinator.marker!.map = mapView
            }
            context.coordinator.marker?.position = locationManager.markerPosition
            mapView.animate(toLocation: locationManager.markerPosition)
        } else {
            mapView.clear()
            if let result = viewModel.favors {
                for item in result {
                    let location = CLLocationCoordinate2D(latitude: item.lat ?? 0.0, longitude: item.lng ?? 0.0)
                    let marker = GMSMarker()
                    marker.position = location
                    marker.map = mapView
                    marker.title = item.title
                    mapView.animate(toLocation: location)
                }
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, GMSMapViewDelegate, CLLocationManagerDelegate {
        var parent: MapView
        var marker: GMSMarker? // Store the marker in the coordinator

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
            parent.locationManager.markerPosition = marker.position
            parent.locationManager.location = CLLocation(latitude: marker.position.latitude, longitude: marker.position.longitude)
            parent.locationManager.reverseGeocode(location: CLLocation(latitude: marker.position.latitude, longitude: marker.position.longitude))
            parent.locationManager.presentSheet.toggle()
        }
        
        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            
            if let tappedLocation = parent.viewModel.favors?.first(where: { $0.title == marker.title }) {
                parent.viewModel.favor_detail = tappedLocation
                parent.isPresented.toggle()
            }
            
            return true
        }

    }
}
