//
//  MapView.swift
//  Departures
//
//  Created by Namasang Yonzan on 09/06/21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    //Variables
    @EnvironmentObject var mapData: MapViewModel
        
    func makeCoordinator() -> Coordinator {
        return MapView.Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let view = mapData.mapView
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    //MARK: Mapview Delegate
    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation.isKind(of: MKUserLocation.self){ return nil }
            else {
                let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PIN_VIEW")
                pinAnnotation.tintColor = .red
                pinAnnotation.animatesDrop = true
                pinAnnotation.canShowCallout = true
                
                return pinAnnotation
            }
        }
    }
   
}
