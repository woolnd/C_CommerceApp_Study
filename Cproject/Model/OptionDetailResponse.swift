//
//  OptionDetailResponse.swift
//  Cproject
//
//  Created by wodnd on 4/18/25.
//

import Foundation

struct OptionDetailResponse: Decodable{
    var option: [OptionDetail]
}

struct OptionDetail: Decodable {
    var name: String
    var imageUrl: String
    var price: String
}

