//
//  HomeProductCell.swift
//  Cproject
//
//  Created by wodnd on 4/1/25.
//

import UIKit
import Kingfisher

struct HomeProductCellViewModel: Hashable {
    let imageUlrString: String
    let title: String
    let reasonDiscountString: String
    let originalPriceString: String
    let discountPriceString: String
}

final class HomeProductCell: UICollectionViewCell {
    static let reusableId: String = "HomeProductCell"
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var reasonDiscountLabel: UILabel!
    @IBOutlet private weak var originalLabel: UILabel!
    @IBOutlet private weak var discountLabel: UILabel!
    
    func configure(_ viewModel: HomeProductCellViewModel){
        imageView.kf.setImage(with: URL(string: viewModel.imageUlrString))
        imageView.layer.cornerRadius = 5
        imageView.backgroundColor = .blue
        titleLabel.text = viewModel.title
        reasonDiscountLabel.text = viewModel.reasonDiscountString
        originalLabel.attributedText = NSMutableAttributedString(string: viewModel.originalPriceString, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        discountLabel.text = viewModel.discountPriceString
        
    }
}

extension HomeProductCell {
    static func horizontalProdectItemLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(117), heightDimension: .estimated(224))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        section.contentInsets = .init(top: 40, leading: 33, bottom: 0, trailing: 33)
        section.interGroupSpacing = 14
        
        return section
    }
    
    static func verticalProductItemLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(277))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 2.5, bottom: 0, trailing: 2.5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(277))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 40, leading: 19 - 2.5, bottom: 0, trailing: 19 - 2.5)
        
        return section
        
    }
}
