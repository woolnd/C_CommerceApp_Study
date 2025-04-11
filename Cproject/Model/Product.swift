//
//  Product.swift
//  Cproject
//
//  Created by wodnd on 4/11/25.
//

import Foundation
struct Product: Decodable{
    let id: Int
    let imageUrl: String
    let title: String
    let discount: String
    let originalPrice: Int
    let discountPrice: Int
}
