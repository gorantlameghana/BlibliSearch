//
//  SearchBarDelegate.swift
//  CollectionView
//
//  Created by Gorantla Meghana on 27/06/19.
//  Copyright © 2019 Meghana. All rights reserved.
//

import UIKit

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text else {return}
        searchTerm = search
        noDataLable.isHidden = true
        spinner = showLoader(view: self.view)
        searchBar.endEditing(true)
        pageNo = 0
        let params: [String:String] = ["searchTerm": searchTerm, "start": String(pageNo), "itemPerPage": String(itemsPerPage)]
        self.responseProducts.removeAll()
        self.collectionViewController.reloadData()
        getProducts(params: params)
    }
}
