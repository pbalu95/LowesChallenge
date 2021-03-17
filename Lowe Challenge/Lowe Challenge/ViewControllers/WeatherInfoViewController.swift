//
//  WeatherInfoViewController.swift
//  LowesChallenge
//
//  Created by Balaji Peddaiahgari on 3/13/21.
//

import UIKit

class WeatherInfoViewController: UIViewController, UIGestureRecognizerDelegate {

    var viewModel: ListCollectionViewModel?
    
    var listCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.addSubview(listCollectionView)
        listCollectionView.backgroundColor = .clear
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        listCollectionView.pinView(to: view)
        listCollectionView.register(UINib(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "listCell")
    }

}

extension WeatherInfoViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.rowCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as? ListCollectionViewCell,
              let rowData = viewModel?.getRowData(indexPath: indexPath) else {
            return UICollectionViewCell()
        }
        cell.listLabel.text = rowData.listType.rawValue
        cell.backgroundColor = .lightGray
        cell.roundCorners()
        return cell
    }
}

extension WeatherInfoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailVC.viewModel = self.viewModel?.getRowData(indexPath: indexPath)
        self.navigationController?.pushViewController(detailVC, animated: true)
        collectionView.deselectItem(at: indexPath, animated: false)
    }
}

extension WeatherInfoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 50, left:0, bottom: 50, right: 0)
    }
}
