//
//  ListCollectionViewModel.swift
//  LowesChallenge
//
//  Created by Balaji Peddaiahgari on 3/13/21.
//

import Foundation

enum ListCollectionType: String {
    case Weather = "Weather"
    case Temperature = "Temperature"
}

struct ListCollectionModel {
    var listType: ListCollectionType
    var listModel: Any
}
