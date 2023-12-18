//
//  MapView.swift
//  FoodDeliveryApp
//
//  Created by Nasser Faris on 03/06/1445 AH.
//

import SwiftUI
import MapKit
import UIKit

struct MapView: UIViewRepresentable {
    let latitude: Double
    let longitude: Double

    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)

        uiView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = location

        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotation(annotation)
    }
}
/*
 
 import UIKit

 class ViewController: UIViewController {

     // Function to open the location in Google Maps
     func openInGoogleMaps(latitude: Double, longitude: Double) {
         if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
             UIApplication.shared.open(URL(string:
                 "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")!,
                                       options: [:], completionHandler: nil)
         } else {
             // If Google Maps is not installed, open in Apple Maps
             let mapURL = URL(string: "http://maps.apple.com/?ll=\(latitude),\(longitude)")!
             UIApplication.shared.open(mapURL, options: [:], completionHandler: nil)
         }
     }

     // Example usage
     override func viewDidLoad() {
         super.viewDidLoad()
         
         // Replace these coordinates with the ones you want to open
         let latitude = 37.7749
         let longitude = -122.4194
         
         openInGoogleMaps(latitude: latitude, longitude: longitude)
     }
 }

 
 */
