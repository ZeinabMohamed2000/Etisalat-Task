//
//  ViewController.swift
//  Etisalat Task
//
//  Created by Zeinab on 14/11/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var seriesTableView: UITableView!
    var seriesViewModel = SeriesViewModel ()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.layer.cornerRadius = 10
        
        seriesTableView.dataSource = self
        seriesTableView.delegate = self
        
        let nib = UINib(nibName: "SeriesCustomCell", bundle: nil)
        seriesTableView.register(nib, forCellReuseIdentifier: "seriesCell")
        
        
        seriesViewModel.getMoreSeries(offset: seriesViewModel.currentoffset, limit: seriesViewModel.itemsPerPage)
        seriesViewModel.bindingSeriesToController = {
            DispatchQueue.main.async {
                self.seriesViewModel.seriesArr = self.seriesViewModel.retreivedSeries
                self.seriesViewModel.searchedSeries = self.seriesViewModel.seriesArr
                self.seriesTableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seriesViewModel.searchedSeries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "seriesCell", for: indexPath) as! SeriesCustomCell
        
        cell.seriesName.text = seriesViewModel.searchedSeries?[indexPath.row].title
        cell.seriesRate.text = (seriesViewModel.searchedSeries?[indexPath.row].rating == "") ? "-" : seriesViewModel.searchedSeries?[indexPath.row].rating
        cell.seriesYear.text = "\(seriesViewModel.searchedSeries?[indexPath.row].startYear ?? 0)"
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == (seriesViewModel.seriesArr?.count ?? 0) - 1 {
            // User is scrolling to the last cell, load more data
            seriesViewModel.getMoreSeries(offset: seriesViewModel.currentoffset + 1, limit: seriesViewModel.itemsPerPage)
                    }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
        
        seriesTableView.reloadData()
    }
}

//extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        let lastItemIndex = collectionView.numberOfItems(inSection: 0) - 1
//        
//        if indexPath.item == lastItemIndex {
//                    // User is scrolling to the last cell, load more data
//            seriesViewModel.getMoreSeries(offset: seriesViewModel.currentoffset + 1, limit: seriesViewModel.itemsPerPage)
//                }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//       
//        return CGSize(width: (UIScreen.main.bounds.size.width/2) - 10, height: (UIScreen.main.bounds.size.height/5) - 10)
//       
//    }
//    
//    
//}

