//
//  VC_Map.swift
//  TestFB
//
//  Created by NHF on 2016/10/16.
//  Copyright © 2016年 NHF. All rights reserved.
//

import MapKit
import UIKit

class VC_Map : VC_BaseVC,MKMapViewDelegate,CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView_map: MKMapView!
    
    var address : String! = ""
//    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView_map.delegate = self
//        locationManager.delegate = self
        
//        locationManager.requestWhenInUseAuthorization()
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
//            locationManager.requestLocation()
//        }
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address, completionHandler:{ placemarks,error in
            
            if error != nil {
                print(error)
                return
            }
            
            if let placemarks = placemarks{
            
                let placemark = placemarks[0]
                
            let annotation = MKPointAnnotation()
            
                annotation.title = Store.name
            
                annotation.coordinate = (placemark.location?.coordinate)!
                
                self.mapView_map.showAnnotations([annotation], animated: true)
                
                self.mapView_map.selectAnnotation(annotation,animated : true)
            }
        })
    }
}
