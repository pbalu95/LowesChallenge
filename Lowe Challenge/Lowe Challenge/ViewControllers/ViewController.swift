//
//  ViewController.swift
//  LowesChallenge
//
//  Created by Balaji Peddaiahgari on 3/13/21.
//

import UIKit

class ViewController: UIViewController {

    lazy var viewModel: WeatherMapViewModelProtocol = {
        let vm  = WeatherMapViewModel()
        return vm
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 30
        return view
    }()
    
    let textField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Enter city name"
        view.borderStyle = .roundedRect
        view.textAlignment = .center
        return view
    }()
    
    let lookUpButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(didTapLookupButton), for: .touchUpInside)
        view.setTitle("Lookup", for: .normal)
        view.setTitleColor(.darkText, for: .normal)
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }

    func loadModel(with cityName: String) {
        viewModel.fetchCharactersAPIRequest(with: cityName) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                guard let viewModel = response else { return }
                DispatchQueue.main.async {
                    self.segueToInfoViewController(viewModel: viewModel)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(for: error.rawValue)
                }
            }
        }
    }
    
    func setupView() {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .systemBlue
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(lookUpButton)
        view.addSubview(stackView)
        stackView.center(in: view)
    }
    
    @objc func didTapLookupButton() {
        guard let text = textField.text?.lowercased(),
            !text.isEmpty else {
            return
        }
        let textWithoutSpaces = text.replacingOccurrences(of: " ", with: "")
        loadModel(with: textWithoutSpaces)
    }
    
    private func segueToInfoViewController(viewModel: WeatherAPI) {
        let weatherVC = WeatherInfoViewController(nibName: "WeatherInfoViewController", bundle: nil)
        let listViewModel = ListCollectionViewModel()
        listViewModel.buildModel(viewModel: viewModel)
        weatherVC.viewModel = listViewModel
        let backBTN = UIBarButtonItem(title: textField.text?.capitalized, style: .plain, target: nil, action: #selector(didPressBack))
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backBTN
        self.navigationController?.pushViewController(weatherVC, animated: true)
    }
    
    @objc private func didPressBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func showAlert(for error: String) {
        let alertController = UIAlertController(title: error, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true) {
            self.textField.text?.removeAll()
        }
    }
}
