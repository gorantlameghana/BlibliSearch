//
//  CollectionViewDataSourceDelegate.swift
//  CollectionView
//
//  Created by Gorantla Meghana on 27/06/19.
//  Copyright © 2019 Meghana. All rights reserved.
//

import UIKit

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return responseProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //For Cell created by xib
        //guard let productCell = cell as? ProductCell else {return}
        guard let productCell = cell as? ProgramaticProductCellCollectionViewCell else {return}
        productCell.productName.text = responseProducts[indexPath.row].name
        guard let images = responseProducts[indexPath.row].images else { return }
        let url = URL(string: images[0])
        productCell.productImage.kf.setImage(with: url)
        productCell.productPrice.text = responseProducts[indexPath.row].price?.priceDisplay
        if responseProducts[indexPath.row].review?.count != 0 {
            guard let rating = responseProducts[indexPath.row].review?.rating else { return }
            productCell.productRating.attributedText = NSMutableAttributedString().starWithRating(rating: Float(rating), outOfTotal: 5, withFontSize: 30)
        }
        if indexPath.row == responseProducts.count - 1, searchBool == false {
            spinner = showLoader(view: self.view)
        }
        if indexPath.row == responseProducts.count - 1 && responseProducts.count == (pageNo * itemsPerPage) && searchBool == true {
            searchBool = false
            let params: [String:String] = ["searchTerm": searchTerm, "start": String(pageNo), "itemPerPage": String(itemsPerPage)]
            getProducts(params: params)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //For Cell created by xib
        //guard let cell = collectionViewController.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ProductCell else { return UICollectionViewCell()}
        guard let cell = collectionViewController.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ProgramaticProductCellCollectionViewCell else {return UICollectionViewCell()}
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

