//
//  ProductDetailResponse.swift
//  Cproject
//
//  Created by wodnd on 4/12/25.
//

import Foundation

struct ProductDetailResponse: Decodable{
    var bannerImages: [String]
    var product: ProductDetail
    var option: ProductDetailOption
    var detailImages: [String]
}

struct ProductDetail: Decodable {
    var name: String
    var discountPercent: Int
    var originalPrice: Int
    var discountPrice: Int
    var rate: Int
}

struct ProductDetailOption: Decodable {
    var type: String
    var name: String
    var image: String
}
