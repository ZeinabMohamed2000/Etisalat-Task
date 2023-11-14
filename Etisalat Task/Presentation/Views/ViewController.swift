//
//  ViewController.swift
//  Etisalat Task
//
//  Created by Zeinab on 14/11/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    let names = ["Zeinab" , "Salma" , "Habiba" , "Aya" , "Sara" , "Fatma" , "Omar"]
    var searchedNames : [String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.layer.cornerRadius = 10
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

