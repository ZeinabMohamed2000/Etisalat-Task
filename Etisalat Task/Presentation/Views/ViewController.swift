//
//  ViewController.swift
//  Etisalat Task
//
//  Created by Zeinab on 14/11/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    var seriesViewModel = SeriesViewModel ()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.layer.cornerRadius = 10
        
        seriesCollectionView.dataSource = self
        seriesCollectionView.delegate = self
        
        let nib = UINib(nibName: "SeriesCollectionViewCell", bundle: nil)
        seriesCollectionView.register(nib, forCellWithReuseIdentifier: "seriesCell")
        
        seriesViewModel.getSeries()
        seriesViewModel.bindingSeriesToController = {
            DispatchQueue.main.async {
                self.seriesViewModel.seriesArr = self.seriesViewModel.retreivedSeries
                self.seriesViewModel.searchedSeries = self.seriesViewModel.seriesArr
                self.seriesCollectionView.reloadData()
            }
        }
    }
}


extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        seriesViewModel.searchedSeries = []
        if searchText == "" {
            seriesViewModel.searchedSeries = seriesViewModel.seriesArr
        }
        
        for series in seriesViewModel.seriesArr ?? [] {
            if (series.title?.uppercased() ?? "").contains(searchText.uppercased()) {
                seriesViewModel.searchedSeries?.append(series)
            }
        }
        
        seriesCollectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seriesViewModel.searchedSeries?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seriesCell", for: indexPath) as! SeriesCollectionViewCell
        
        cell.seriesName.text = seriesViewModel.searchedSeries?[indexPath.row].title
        cell.seriesRate.text = (seriesViewModel.searchedSeries?[indexPath.row].rating == "") ? "-" : seriesViewModel.searchedSeries?[indexPath.row].rating
        cell.seriesYear.text = "\(seriesViewModel.searchedSeries?[indexPath.row].startYear ?? 0)"
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: (UIScreen.main.bounds.size.width/2) - 10, height: (UIScreen.main.bounds.size.height/5) - 10)
       
    }
    
    
}

