//
//  FavoriteItemTableViewCell.swift
//  Cproject
//
//  Created by wodnd on 4/11/25.
//

import UIKit
import Kingfisher

struct FavoriteItemTableViewCellViewModel: Hashable {
    let imageUrl: String
    let productName: String
    let productPrice: String
}

final class FavoriteItemTableViewCell: UITableViewCell {
    static let resuableId: String = "FavoriteItemTableViewCell"
    
    @IBOutlet weak var productItemImageView: UIImageView!
    @IBOutlet weak var productItemNameLabel: UILabel!
    @IBOutlet weak var productItemPriceLabel: UILabel!
    
    func configure(_ viewModel: FavoriteItemTableViewCellViewModel) {
        
        productItemImageView.kf.setImage(with:  URL(string: viewModel.imageUrl))
        productItemNameLabel.text = viewModel.productName
        productItemPriceLabel.text = viewModel.productPrice
    }
}
