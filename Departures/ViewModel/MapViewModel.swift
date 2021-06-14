//
//  MapViewModel.swift
//  Departures
//
//  Created by Namasang Yonzan on 09/06/21.
//

import Foundation
import MapKit
import SwiftyJSON

class MapViewModel: NSObject,ObservableObject,CLLocationManagerDelegate {
    
    @Published var mapView = MKMapView()
    
    // Region ...
    @Published var region: MKCoordinateRegion!
    
    @Published var permissionDenied = false
    
    @Published var transports: [Transport] = []
    
    @Published var filterTransports: [Transport] = []
    
    
    func fetchItems(completion: @escaping (_ error: Error?) -> Void) {
        Transport.getTransportList { [weak self] (list, error) in
            if let error = error {
                completion(error)
            } else {
                print("TOTAL ITEMS: \(list.count)")
                self?.transports = list
                self?.filterTransports = list
                completion(nil)
            }
        }
    }
    
    
    func focusLocation() {
        guard let _ = region else { return }
        mapView.setRegion(self.region, animated: true)
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
    
    func showTransportList() {
        self.filterTransports = self.transports
        self.showPlace()
    }
    
    func showTrainList() {
        self.filterTransports = self.transports.filter{ $0.typeId == 0 }
        self.showPlace()
    }
    
    func showTramList() {
        self.filterTransports = self.transports.filter{ $0.typeId == 1 }
        self.showPlace()
    }
    
    func showExpressList() {
        self.filterTransports = self.transports.filter{ $0.isExpress == true && $0.typeId == 0 }
        self.showPlace()
    }
    
    func showNormalList() {
        self.filterTransports = self.transports.filter{ $0.isExpress == false && $0.typeId == 0 }
        self.showPlace()
    }
    
    func showTopupList() {
        self.filterTransports = self.transports.filter{ $0.hasMyKiTopUp == true && $0.typeId == 1 }
        self.showPlace()
    }
    
    func showNoTopupList() {
        self.filterTransports = self.transports.filter{ $0.hasMyKiTopUp == false && $0.typeId == 1 }
        self.showPlace()
    }
    
    func showPlace() {
        let locations = self.filterTransports
        mapView.removeAnnotations(mapView.annotations)
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.title = location.typeId == 0 ? location.name + " (Train)" : location.name + " (Tram)"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let date = dateFormatter.date(from: location.departureTime)
            dateFormatter.dateFormat = date?.dateFormatWithSuffix()
            dateFormatter.amSymbol = "am"
            dateFormatter.pmSymbol = "pm"
            let subtitle = dateFormatter.string(from: date ?? Date())
            annotation.subtitle = subtitle
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            mapView.addAnnotation(annotation)
        }
        let coordinate = CLLocationCoordinate2DMake(-37.8181755, 144.9661256)
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 30000, longitudinalMeters: 30000)
        self.mapView.setRegion(coordinateRegion, animated: true)
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
        let coordinate = CLLocationCoordinate2DMake(-37.8181755, 144.9661256)
        self.region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 30000, longitudinalMeters: 30000)
        self.mapView.setRegion(self.region, animated: true)
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
}


