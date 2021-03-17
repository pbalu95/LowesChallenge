//
//  ListCollectionViewModel.swift
//  LowesChallenge
//
//  Created by Balaji Peddaiahgari on 3/13/21.
//

import Foundation

protocol ListCollectionViewProtocol {
    var rowCount: Int { get }
    func getRowData(indexPath: IndexPath) -> ListCollectionModel?
}

class ListCollectionViewModel: ListCollectionViewProtocol {
    
    private var listViewModel: [ListCollectionModel]?

    var rowCount: Int {
        return listViewModel?.count ?? 0
    }

    func buildModel(viewModel: WeatherAPI) {

        let weatherItem =  ListCollectionModel(listType: .Weather, listModel: viewModel.list?.first?.weather as Any)
        let temperatureItem = ListCollectionModel(listType: .Temperature, listModel: viewModel.list?.first?.main as Any)
        var vm: [ListCollectionModel] = [ListCollectionModel]()
        vm.append(weatherItem)
        vm.append(temperatureItem)
        listViewModel = vm
    }

    func getRowData(indexPath: IndexPath) -> ListCollectionModel? {
        return self.listViewModel?[indexPath.row]
    }
}
