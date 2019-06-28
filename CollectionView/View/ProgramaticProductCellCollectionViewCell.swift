//
//  ProgramaticProductCellCollectionViewCell.swift
//  CollectionView
//
//  Created by Gorantla Meghana on 25/06/19.
//  Copyright © 2019 Meghana. All rights reserved.
//

import UIKit

class ProgramaticProductCellCollectionViewCell: UICollectionViewCell {
    
    let productImage = UIImageView()
    let productName = UILabel()
    let productPrice = UILabel()
    let productRating = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        productName.numberOfLines = 2
        productImage.contentMode = .scaleAspectFit
        addSubview(productImage)
        addSubview(productName)
        addSubview(productPrice)
        addSubview(productRating)
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productName.translatesAutoresizingMaskIntoConstraints = false
        productPrice.translatesAutoresizingMaskIntoConstraints = false
        productRating.translatesAutoresizingMaskIntoConstraints = false
        //Constraints for Product Image
        productImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        productImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        productImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        productImage.bottomAnchor.constraint(equalTo: productName.topAnchor, constant: -10).isActive = true
        productImage.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .vertical)
        //Constraints for Product Name
        productName.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 10).isActive = true
        productName.leadingAnchor.constraint(equalTo: productImage.leadingAnchor, constant: 0).isActive = true
        productName.trailingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 0).isActive = true
        productName.bottomAnchor.constraint(equalTo: productPrice.topAnchor, constant: -10).isActive = true
        //Constraints for Product Price
        productPrice.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 10).isActive = true
        productPrice.leadingAnchor.constraint(equalTo: productImage.leadingAnchor, constant: 0).isActive = true
        productPrice.trailingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 0).isActive = true
        productPrice.bottomAnchor.constraint(equalTo: productRating.topAnchor, constant: -10).isActive = true
        //Constraints for Product Rating
        productRating.topAnchor.constraint(equalTo: productPrice.bottomAnchor, constant: 10).isActive = true
        productRating.leadingAnchor.constraint(equalTo: productImage.leadingAnchor, constant: 0).isActive = true
        productRating.trailingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 0).isActive = true
        productRating.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
}
