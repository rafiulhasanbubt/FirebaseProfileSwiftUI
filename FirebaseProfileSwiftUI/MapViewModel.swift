//
//  MapViewModel.swift
//  FirebaseProfileSwiftUI
//
//  Created by rafiul hasan on 15/9/21.
//

import Foundation
import MapKit
import CoreLocation

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var mapView = MKMapView()
    @Published var region: MKCoordinateRegion!
    //alert
    @Published var permissionDenied = false
    //Searchplace
    @Published var places: [Place] = []
    //search
    @Published var searchTxt = ""
    func searchQuery() {
        places.removeAll()
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTxt
        MKLocalSearch(request: request).start { response, _ in
            guard let result = response else { return }
            self.places = result.mapItems.compactMap({ item -> Place? in
                return Place(place: item.placemark)
            })
        }
    }
    // pick search result
    func selectPlace(place: Place) {
        searchTxt = ""
        guard let coordinate = place.place.location?.coordinate else {
            return
        }
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.place.name ?? "no name"
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(pointAnnotation)
        
        //moving pick
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    //maptype
    @Published var mapType: MKMapType = .standard
    func updateMapType() {
        if mapType == .standard {
            mapType = .hybrid
            mapView.mapType = mapType
        } else {
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
    func focusLocation() {
        guard let _ = region else { return }
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied:
            permissionDenied.toggle()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            manager.requestLocation()
        default:
            ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        self.mapView.setRegion(self.region, animated: true)
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
}
