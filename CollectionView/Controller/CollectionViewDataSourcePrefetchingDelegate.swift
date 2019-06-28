//
//  CollectionViewDataSourceDelegate.swift
//  CollectionView
//
//  Created by Gorantla Meghana on 27/06/19.
//  Copyright © 2019 Meghana. All rights reserved.
//

import UIKit

extension ViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in 0..<indexPaths.count {
            if indexPaths[indexPath][1] > responseProducts.count - 10 && responseProducts.count == (pageNo * itemsPerPage) && searchBool == true {
                searchBool = false
                let params: [String:String] = ["searchTerm": searchTerm, "start": String(pageNo), "itemPerPage": String(itemsPerPage)]
                getProducts(params: params)
            }
        }
    }
}
