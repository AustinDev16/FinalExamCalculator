//
//  AppearenceController.swift
//  FinalExamCalculator
//
//  Created by Austin Blaser on 9/23/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import UIKit

public let textFont = "Avenir-Medium"
public let greyColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 0.49)
public let blueColor = UIColor(red: 133/255, green: 198/255, blue: 234/255, alpha: 1)
public let redColor = UIColor(red: 208/255.0, green: 2/255.0, blue: 50/255.0, alpha: 1.0)


class AppearenceController{
    static func gradient() -> CAGradientLayer {
        let topColor = blueColor.CGColor
        let bottomColor = UIColor.lightGrayColor().CGColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor, bottomColor]
       // gradientLayer.locations = [0.0, 0.8]
        gradientLayer.locations = [0.3, 1.2]
        
        return gradientLayer
    }
}