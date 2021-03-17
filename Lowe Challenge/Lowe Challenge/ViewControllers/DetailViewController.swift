//
//  DetailViewController.swift
//  LowesChallenge
//
//  Created by Balaji Peddaiahgari on 3/13/21.
//

import UIKit

class DetailViewController: UIViewController {

    var viewModel: ListCollectionModel?
    
    let stackView: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let subTitleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindModel()
    }

    private func setupView() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        view.addSubview(stackView)
        stackView.center(in: view)
    }
    
    private func bindModel() {
        guard let vm = viewModel else { return }
        switch vm.listType {
        case .Temperature:
            guard let tempViewModel = vm.listModel as? MainData,
                  let temp = tempViewModel.temp,
                  let feelsLike = tempViewModel.feelsLike else { return }
            titleLabel.text = "Temperature : ".appending(temp.convertToCelsiusString())
            subTitleLabel.text = "Feels like: ".appending(feelsLike.convertToCelsiusString())
        case .Weather:
            guard let weatherViewModel = vm.listModel as? [Weather],
                  let main = weatherViewModel.first?.main?.capitalized,
                  let description = weatherViewModel.first?.description?.capitalized else { return }
            titleLabel.text = "Weather: \(main)"
            subTitleLabel.text = "Description: \(description)"
        }
    }
}
