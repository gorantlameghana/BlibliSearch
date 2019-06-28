//
//  Data.swift
//  CollectionView
//
//  Created by Gorantla Meghana on 27/06/19.
//  Copyright © 2019 Meghana. All rights reserved.
//

import UIKit

class DataOfProduct: Codable {
    var searchTerm: String?
    var products: [Products]?
    
    //    enum CodingKeys: String, CodingKey {
    //        case searchTerm
    //        case products
    //    }
}
