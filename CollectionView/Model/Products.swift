//
//  Products.swift
//  CollectionView
//
//  Created by Gorantla Meghana on 27/06/19.
//  Copyright © 2019 Meghana. All rights reserved.
//

import UIKit

class Products: Codable {
    var id: String?
    var name: String?
    var images: [String]?
    var price: Price?
    var review: Review?
    
    //    enum CodingKeys: String, CodingKey {
    //        case id
    //        case name
    //        case images
    //    }
}
