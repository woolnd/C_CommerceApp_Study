//
//  HomeProductCell.swift
//  Cproject
//
//  Created by wodnd on 4/1/25.
//

import UIKit

struct HomeProductCellViewModel: Hashable {
    let imageUlrString: String
    let title: String
    let reasonDiscountString: String
    let originalPriceString: String
    let discountPriceString: String
}

class HomeProductCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reasonDiscountLabel: UILabel!
    @IBOutlet weak var originalLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    
    func configure(_ viewModel: HomeProductCellViewModel){
//        imageView.image =
        imageView.layer.cornerRadius = 5
        imageView.backgroundColor = .blue
        titleLabel.text = viewModel.title
        reasonDiscountLabel.text = viewModel.reasonDiscountString
        originalLabel.attributedText = NSMutableAttributedString(string: viewModel.originalPriceString, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        discountLabel.text = viewModel.discountPriceString
        
    }
}
