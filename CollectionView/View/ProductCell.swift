//
//  CustomCell.swift
//  CollectionView
//
//  Created by Gorantla Meghana on 24/06/19.
//  Copyright © 2019 Meghana. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet var productCellView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        CommonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        CommonInit()
    }
    
    func CommonInit() {
        Bundle.main.loadNibNamed("ProductCell", owner: self, options: nil)
        self.addSubview(productCellView)
        //setting constraints for view
        productCellView.translatesAutoresizingMaskIntoConstraints  = false
        productCellView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        productCellView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        productCellView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        productCellView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
