//
//  ScoreCalc.swift
//  Quality Of Area
//
//  Created by Ryan Tremblay on 11/21/15.
//  Copyright © 2015 Ryan Tremblay. All rights reserved.
//

import Foundation
import MapKit

var crimeLocations = getCrimeCoords()
// Calculate scores here. 

func getCrimeCoords() -> Array<CLLocationCoordinate2D> {
//JSON decode code
let filePath = NSBundle.mainBundle().pathForResource("nyccrimedata2015", ofType: "json")
let data =  NSData(contentsOfFile: filePath!)
let json = JSON(data: data!)
let actualData = json["features"]
//Loop creates an array of coordinate arrays.
    let looper = actualData.count
    
    var crimeCoords:Array = [CLLocationCoordinate2D]()
    
    for var index = 0; index < looper; index++ {
        
        //var coordinates = actualData[index]["geometry"]["coordinates"]
        var long = actualData[index]["geometry"]["coordinates"][0].stringValue
        var lat = actualData[index]["geometry"]["coordinates"][1].stringValue
        //crimeCoords.append([[lat, long]])
        //print(lat)
        //print(long)
        
        crimeCoords.append(CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!))
        
        //crimeCoords.append((actualData[index]["geometry"]["coordinates"]))

        //DEBUG: Prints the coord array (as it is being made?)
        print(actualData[index]["geometry"]["coordinates"])
        
        
    
        
        }
    //print(actualData.count)
    return crimeCoords

}
func getCrimeData(location: Int) -> String {
    //JSON decode code
    let filePath = NSBundle.mainBundle().pathForResource("nyccrimedata2015", ofType: "json")
    let data =  NSData(contentsOfFile: filePath!)
    let json = JSON(data: data!)
    let actualData = json["features"]
    
    var result = String(actualData[location]["properties"]["CR"])
    
    return result
}

func getCrimesWithinMile(loc: CLLocationCoordinate2D) -> Int {
    // Return number of crimes reported within a mi le of given coordinate
    var numOfCrimes:Int = 0
    
    let crimeCoords = crimeLocations
    
    for var index = 0; index < crimeCoords.count; index++ {
        // They were backwards!
        var getLat: CLLocationDegrees = crimeCoords[index].latitude
        var getLong: CLLocationDegrees = crimeCoords[index].longitude
        var getConvertedCrimeLocation: CLLocation =  CLLocation(latitude: getLat, longitude: getLong)
        var getInputLat: CLLocationDegrees = loc.latitude
        var getInputLong: CLLocationDegrees = loc.longitude
        var getConvertedInputLocation: CLLocation = CLLocation(latitude: getInputLat, longitude: getInputLong)
        
        var distance = getConvertedInputLocation.distanceFromLocation(getConvertedCrimeLocation) / 1000
        //print(distance)
        if distance <= 1 {
            numOfCrimes++
            print("yes")
            
        } else {
            // print("no")
        }
        
        
    }
    
    print(numOfCrimes)
    
    return numOfCrimes
    

}