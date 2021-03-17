//
//  WeatherModel.swift
//  LowesChallenge
//
//  Created by Balaji Peddaiahgari on 3/13/21.
//

import Foundation

struct WeatherAPI: Codable {
    let responseCode: String?
    let count: Int?
    let list: [List]?
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "cod"
        case count = "cnt"
        case list = "list"
    }
}

struct List: Codable {
    let main: MainData?
    let weather: [Weather]?
}


struct MainData: Codable {
    let temp: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Double?
    let seaLevel: Int?
    let groundLevel: Int?
    let humidity: Int?
    let tempKf: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
        case humidity = "humidity"
        case tempKf = "temp_kf"
    }
}

struct Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}
