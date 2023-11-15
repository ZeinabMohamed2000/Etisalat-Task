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
    let names = ["Zeinab" , "Salma" , "Habiba" , "Aya" , "Sara" , "Fatma" , "Omar"]
    var searchedNames : [String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.layer.cornerRadius = 10
        
        seriesCollectionView.dataSource = self
        seriesCollectionView.delegate = self
        
        let nib = UINib(nibName: "SeriesCollectionViewCell", bundle: nil)
        seriesCollectionView.register(nib, forCellWithReuseIdentifier: "seriesCell")
    }


}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchedNames = []
        if searchText == "" {
            searchedNames = names
        }
        
        for letter in names {
            if letter.uppercased().contains(searchText.uppercased()) {
                searchedNames?.append(letter)
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seriesCell", for: indexPath) as! SeriesCollectionViewCell
        
        cell.seriesName.text = "any movie"
        cell.seriesRate.text = "10"
        cell.seriesYear.text = "1999"
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: (UIScreen.main.bounds.size.width/2) - 10, height: (UIScreen.main.bounds.size.height/5) - 10)
       
    }
    
    
}

