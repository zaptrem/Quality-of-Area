//
//  ViewController.swift
//  Quality Of Area
//
//  Created by Ryan Tremblay on 11/21/15.
//  Copyright © 2015 Ryan Tremblay. All rights reserved.
// Fried chicken

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var myMap: MKMapView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            
            
            let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(0.01 , 0.01)
            let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 40.793262, longitude: -73.974448)
            let theRegion:MKCoordinateRegion = MKCoordinateRegionMake(location, theSpan)
            
            myMap.setRegion(theRegion, animated: true)
            
//            var anotation = MKPointAnnotation()
//            anotation.coordinate = location
//            anotation.title = "The Location"
//            anotation.subtitle = "This is the location !!!"
//            myMap.addAnnotation(anotation)
        
            let longPress = UILongPressGestureRecognizer(target: self, action: "action:")
            longPress.minimumPressDuration = 1.0
            myMap.addGestureRecognizer(longPress)
            
            
        }
        
        func action(gestureRecognizer:UIGestureRecognizer) {
            var touchPoint = gestureRecognizer.locationInView(self.myMap)
            var newCoord:CLLocationCoordinate2D = myMap.convertPoint(touchPoint, toCoordinateFromView: self.myMap)
            
            var newAnotation = MKPointAnnotation()
            newAnotation.coordinate = newCoord
            newAnotation.title = "New Location"
            newAnotation.subtitle = "Average SAT is " + String(getSatAverage(newCoord)) + ". Nmber of crimes is " + String(getCrimesWithinMile(newCoord))
            myMap.addAnnotation(newAnotation)
            
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

