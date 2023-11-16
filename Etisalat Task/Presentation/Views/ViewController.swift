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
    var seriesViewModel = SeriesNetworkViewModel ()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUp()
        getdata()
    }
    
    func setUp(){
        searchBar.delegate = self
        searchBar.layer.cornerRadius = 10
        seriesTableView.dataSource = self
        seriesTableView.delegate = self
        
        let nib = UINib(nibName: "SeriesCustomCell", bundle: nil)
        seriesTableView.register(nib, forCellReuseIdentifier: "seriesCell")
        
    }
    
    func getdata(){
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
        let series = seriesViewModel.searchedSeries?[indexPath.row]
        cell.configure(title: series?.title ?? "", url: "https://mpc-pharma.com/admin/images/NOVA4_1674558666_87135319.png" , rate: (((series?.rating == "") ?  "-" : series?.rating) ??  ""), year: series?.startYear ?? 0, description: (((series?.description == nil) ?  "-" : series?.description) ??  ""), type: (((series?.type == "") ?  "-" : series?.type) ??  ""))
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == (seriesViewModel.seriesArr?.count ?? 0) - 1 {
            // User is scrolling to the last cell, load more data
            seriesViewModel.getMoreSeries(offset: seriesViewModel.currentoffset + 1, limit: seriesViewModel.itemsPerPage)
                    }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: SeriesCustomCell = tableView.cellForRow(at: indexPath) as! SeriesCustomCell
        cell.isExpanded.toggle()
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
