//
//  ScoreCalc.swift
//  Quality Of Area
//
//  Created by Ryan Tremblay on 11/21/15.
//  Copyright © 2015 Ryan Tremblay. All rights reserved.
//

import Foundation
import MapKit
//import Alamofire

var crimeLocations = getCrimeCoords()
var schoolCoords = getSchoolCoords()

var satScores = getSatScores()
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
        //print(actualData[index]["geometry"]["coordinates"])
        
        
    
        
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
            //print("yesCrime")
            
        } else {
            // print("no")
        }
        
        
    }
    
    //print(numOfCrimes)
    
    return numOfCrimes
    

}
func getSatAverage(loc: CLLocationCoordinate2D) -> Int {
    
    
    let crimeCoords = crimeLocations
    var satScores:Array = [Int]()
    var thingToDivide = 0
    
    var index = 0
    
    //for var index = 0; index < crimeCoords.count; index++ {
    //print(getSatScores())
    for (sat, crimeCoords) in getSatScores() {
        // They were backwards!
        var getLat: CLLocationDegrees = crimeCoords.latitude
        var getLong: CLLocationDegrees = crimeCoords.longitude
        var getConvertedCrimeLocation: CLLocation =  CLLocation(latitude: getLat, longitude: getLong)
        var getInputLat: CLLocationDegrees = loc.latitude
        var getInputLong: CLLocationDegrees = loc.longitude
        //Lat and Long were accidently revered somewhere, and I don't have time to find out where right now, so I called lat long and long lat on the line below for a quick fix.) TODO: Fix!
        var getConvertedInputLocation: CLLocation = CLLocation(latitude: getInputLong, longitude: getInputLat)
        
        var distance = getConvertedInputLocation.distanceFromLocation(getConvertedCrimeLocation) / 1000
        //print(distance)
        if distance <= 2 {
            satScores.append(sat)
            thingToDivide = thingToDivide + sat
            //print("yesSAT")
            //print(distance)
            
        } else {
            //print("noSAT")
            //print(distance)
        }
        
        
    }
    //print(thingToDivide)
    //print(satScores.count)
    var satAverage = 0
    if thingToDivide == 0 {
        //No schools near by! Do something!
        satAverage = 0
        print("No Schools within 2km!")
        
    } else {
        satAverage = thingToDivide / (satScores.count)
        //print(satAverage)
        
        //print(satAverage)
        
        
    }
    //print(satAverage)
    

    return satAverage
    

}

func getSatScores() -> Dictionary<Int, CLLocationCoordinate2D> {
    
    var satData = [Int: CLLocationCoordinate2D]()
    //JSON decode code
    let filePath = NSBundle.mainBundle().pathForResource("SATscore", ofType: "json")
    let data =  NSData(contentsOfFile: filePath!)
    let json = JSON(data: data!)
    let actualData = json["data"]
    //Loop creates an array of coordinate arrays.
    let looper = actualData.count
    
    
    for var index = 0; index < looper; index++ {
        
        
        if (actualData[index][11]).string == "s" {
            //print("Whoops, this school has no SAT results.")
            
        } else {
        var schoolName = (String(actualData[index][9])).uppercaseString
        var schoolCoordinate = schoolCoords[schoolName]
        var satReading = String(actualData[index][11])
        //print(satReading)
        var intsatReading = Int(satReading)
        //print(intsatReading)
        var satMath = String(actualData[index][12])
        var intsatMath = Int(satMath)
        var satWriting = String(actualData[index][13])
        var intsatWriting = Int(satWriting)
        var satComposite = intsatReading!+intsatMath!+intsatWriting!
        var address = "death"
        
        
        //satData[satComposite] = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!)
        //print(satComposite)
        satData[satComposite] = schoolCoordinate
        

        }
        
        
        
    }
    
    return satData
}

func getSchoolCoords() -> Dictionary<String, CLLocationCoordinate2D> {
    //JSON decode code
    let filePath = NSBundle.mainBundle().pathForResource("schooladdresses", ofType: "json")
    let data =  NSData(contentsOfFile: filePath!)
    let json = JSON(data: data!)
    let actualData = json["data"]
    //Loop creates an array of coordinate arrays.
    let looper = actualData.count
    
    var schoolCoords:Dictionary = [String:CLLocationCoordinate2D]()
    
    for var index = 0; index < looper; index++ {
        var schoolNamebefore = actualData[index][9].string!
        var schoolName = schoolNamebefore.uppercaseString
        
        //var coordinates = actualData[index]["geometry"]["coordinates"]
        var long = actualData[index][65][1].stringValue
        var lat = actualData[index][65][2].stringValue
        //crimeCoords.append([[lat, long]])
        //print(lat)
        //print(long)
        
        schoolCoords[schoolName] = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!)
        
        //crimeCoords.append((actualData[index]["geometry"]["coordinates"]))
        
        //DEBUG: Prints the coord array (as it is being made?)
        //print(actualData[index]["geometry"]["coordinates"]) -- ONLY FOR CRIME
        
        
        
        
    }

    
    return schoolCoords
    
}

//func getYelpAverage(loc: CLLocationCoordinate2D) -> Int {
//    let postEndpoint: String = "http://jsonplaceholder.typicode.com/posts/1"
//    Alamofire.request(.GET, postEndpoint)
//        .responseJSON { response in
//            guard response.result.error == nil else {
//                // got an error in getting the data, need to handle it
//                print("error calling GET on /posts/1")
//                print(response.result.error!)
//                return
//            }
//            
//            if let value: AnyObject = response.result.value {
//                // handle the results as JSON, without a bunch of nested if loops
//                let post = JSON(value)
//                // now we have the results, let's just print them though a tableview would definitely be better UI:
//                print("The post is: " + post.description)
//                if let title = post["title"].string {
//                    // to access a field:
//                    print("The title is: " + title)
//                } else {
//                    print("error parsing /posts/1")
//                }
//            }
//    }
//    
//    
//}
func getScore(loc: CLLocationCoordinate2D) -> Double {
    // National average in 2012: 1418
    
    var satAverage:Double = Double(getSatAverage(loc))
    var crime = Double(getCrimesWithinMile(loc))
    
    var crimeRating = 5 - (crime / 100)
    
    var satRating:Double = 3 * ((satAverage / 2400) / 0.59) // (Average/2400)
    
    var finalRating:Double = (crimeRating + satRating) / 2
    
    return finalRating
}
