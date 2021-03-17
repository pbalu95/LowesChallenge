//
//  Extensions.swift
//  LowesChallenge
//
// Created by Balaji Peddaiahgari on 3/13/21.
//

import Foundation

extension Double {
    func convertToCelsiusString() -> String {
        // Formula to convert is tempInKelvin - 273.15
        let temp = self - 273.15
        return String(format: "%.2f", temp).appending(" C")
        
    }
}
