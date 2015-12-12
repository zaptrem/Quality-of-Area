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
    

    @IBOutlet weak var bottomLeftLabel: UILabel!
    @IBOutlet weak var myMap: MKMapView!

    @IBAction func loadHeatMapButton(sender: AnyObject) {
        bottomLeftLabel.text = "Loading Search View"
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            print("HeatMap Activated")
            var bottomRightLimit = CLLocationCoordinate2DMake(CLLocationDegrees(40.504453), CLLocationDegrees(-74.264584))
            //bottomRightLimit.latitude = 40.504453
            //bottomRightLimit.longitude = -74.264584
            var topLeftLimit = CLLocationCoordinate2DMake(CLLocationDegrees(40.918752), CLLocationDegrees(-73.701535))
            //topLeftLimit.latitude = 40.918752
            //topLeftLimit.longitude = -73.701535
            
            var workingLatitudeLimit = 40.918752
            var workingLongitudeLimit = -73.701535
            
            var workingLatitude = 40.504463
            var workingLongitude = -74.264684
            var index = 0
            var annotationArray = Array<MKPointAnnotation>()
            
            while workingLongitude < workingLongitudeLimit {
                while workingLatitude < workingLatitudeLimit{
                    //print(workingLatitude)
                    workingLatitude += 0.001
                    var loc = CLLocationCoordinate2DMake(CLLocationDegrees(workingLatitude), CLLocationDegrees(workingLongitude))
                    //print(loc)
                    print(index)
                    annotationArray.append(MKPointAnnotation())
                    annotationArray[index].coordinate = loc
                    annotationArray[index].title = "New Location"
                    annotationArray[index].subtitle = "Score: "// + String(getScore(loc))
                    
                    index++
                    
                }
                workingLatitude = 40.504463
                workingLongitude += 0.001
                //0.00005
                //print(workingLongitude)
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                // update some UI
                print("UI thing started COUNT IS:")
                print(annotationArray.count)
                var index2 = 0
                for annotation in annotationArray {
                self.myMap.addAnnotation(annotation)
                    index2++
                    //print("should be showing pin")
                }
                self.bottomLeftLabel.text = "Showing Search View"
            }
            print (annotationArray[1])
        }
        
        
    }
    
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
            newAnotation.subtitle = "SAT A:" + String(getSatAverage(newCoord)) + ". Crimes: " + String(getCrimesWithinMile(newCoord)) + "Score: " + String(getScore(newCoord))
            myMap.addAnnotation(newAnotation)
            
        }
    //This isn't the real one.
    func loadHeatMapButtonn() {
        print("HeatMap Activated")
        bottomLeftLabel.text = "Loading Search View"
        var bottomRightLimit = CLLocationCoordinate2DMake(CLLocationDegrees(40.504453), CLLocationDegrees(-74.264584))
            //bottomRightLimit.latitude = 40.504453
            //bottomRightLimit.longitude = -74.264584
        var topLeftLimit = CLLocationCoordinate2DMake(CLLocationDegrees(40.918752), CLLocationDegrees(-73.701535))
            //topLeftLimit.latitude = 40.918752
            //topLeftLimit.longitude = -73.701535
        
        var workingLatitudeLimit = 40.918752
        var workingLongitudeLimit = -73.701535
        
        var workingLatitude = 40.504463
        var workingLongitude = -74.264684
        
        while workingLongitude < workingLongitudeLimit {
            while workingLatitude < workingLatitudeLimit{
                print("looping")
                workingLatitude = +0.00005
                var loc = CLLocationCoordinate2DMake(CLLocationDegrees(workingLatitude), CLLocationDegrees(workingLongitude))
                var newAnotation = MKPointAnnotation()
                newAnotation.coordinate = loc
                newAnotation.title = "New Location"
                newAnotation.subtitle = "Score: " + String(getScore(loc))
            
            }
            workingLongitude = +0.00005
        }
        bottomLeftLabel.text = "Showing Search View"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

