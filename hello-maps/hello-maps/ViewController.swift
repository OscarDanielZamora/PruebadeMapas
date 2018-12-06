//
//  ViewController.swift
//  hello-maps
//
//  Created by Óscar Zamora on 12/5/18.
//  Copyright © 2018 Óscar Zamora. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    private let locationManager = CLLocationManager()
    
    var nombreMapa: String = ""
    var latitudMapa: Double = 0.0
    var longitudMapa: Double = 0.0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        let location = CLLocationCoordinate2DMake(latitudMapa, longitudMapa)
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.0009, longitudeDelta: 0.0009))
        let anotation = Marcador()
        anotation.coordinate = CLLocationCoordinate2DMake(latitudMapa, longitudMapa)
        anotation.title = nombreMapa
        anotation.imagenURL = "pinpoint"
        
        mapView.setCenter(location, animated: true)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(anotation)
        
        mapTypeSegmentedControl.addTarget(self, action: #selector(mapTypeChanged), for: .valueChanged)
        
    }
    
    @objc func mapTypeChanged( segmentedControl: UISegmentedControl){
        switch(segmentedControl.selectedSegmentIndex){
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            mapView.mapType = .standard
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations.first!)
    }
    
    @IBAction func navegar(_ sender: UIButton) {
        
        let startingMapItem = MKMapItem.forCurrentLocation()
        
        let location = CLLocationCoordinate2DMake(latitudMapa, longitudMapa)
        let destinationPlacemark = MKPlacemark(coordinate: location)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
        let directionsRequest = MKDirectionsRequest()
        directionsRequest.transportType = .walking
        directionsRequest.source = startingMapItem
        directionsRequest.destination = destinationMapItem
            
        let directions = MKDirections(request: directionsRequest)
        directions.calculate(completionHandler: { (response, error) in
                
            if let error = error{
                print(error.localizedDescription)
                return
            }
                
            guard let response = response, let route = response.routes.first else{
                return
            }
                
            if !route.steps.isEmpty{
                for step in route.steps{
                    print(step.instructions)
                }
            }
        })
        
        MKMapItem.openMaps(with: [destinationMapItem], launchOptions: nil)
        
    }
    

}

