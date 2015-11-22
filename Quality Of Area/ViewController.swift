//
//  ViewController.swift
//  Quality Of Area
//
//  Created by Ryan Tremblay on 11/21/15.
//  Copyright © 2015 Ryan Tremblay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //JSON decode code
        let filePath = NSBundle.mainBundle().pathForResource("nyccrimedata2015", ofType: "json")
        let data =  NSData(contentsOfFile: filePath!)
        let json = JSON(data: data!)
        //print(json["features"])
        //how do I print a dictionary
        let actualData = json["features"]
        //End JSON decode code
        //print(actualData[2]["geometry"]["coordinates"])

        
        print("hello world.")
        //print(actualData)
        //print(getCrimeCoords())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

