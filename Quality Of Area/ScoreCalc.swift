//
//  ScoreCalc.swift
//  Quality Of Area
//
//  Created by Ryan Tremblay on 11/21/15.
//  Copyright © 2015 Ryan Tremblay. All rights reserved.
//

import Foundation

// Calculate scores here. 

func getCrimeCoords() -> Array<JSON> {
//JSON decode code
let filePath = NSBundle.mainBundle().pathForResource("nyccrimedata2015", ofType: "json")
let data =  NSData(contentsOfFile: filePath!)
let json = JSON(data: data!)
let actualData = json["features"]
//End JSON decode code
    let looper = actualData.count
    
    var crimeCoords:Array = [JSON]()
    
    for var index = 0; index < looper; index++ {
        
        //var coordinates = actualData[index]["geometry"]["coordinates"]
        
        crimeCoords.append((actualData[index]["geometry"]["coordinates"]))

        print(actualData[index]["geometry"]["coordinates"])
        
    
        
        }
    return crimeCoords

}