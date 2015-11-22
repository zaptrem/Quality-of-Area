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
        let filePath = NSBundle.mainBundle().pathForResource("nyccrimedata2015", ofType: "json")
        let data =  NSData(contentsOfFile: filePath!)
        let json = JSON(data: data!)
        var actualData = json["data"]
        // Do any additional setup after loading the view, typically from a nib.
        print("hello world.")
        print()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

