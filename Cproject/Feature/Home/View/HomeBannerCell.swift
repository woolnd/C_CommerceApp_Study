//
//  HomeBannerCell.swift
//  Cproject
//
//  Created by wodnd on 4/1/25.
//

import UIKit
import Kingfisher

struct HomeBannerCellViewModel: Hashable{
    let bannerImageUrl: String
}

final class HomeBannerCell: UICollectionViewCell {
    static let reusableId: String = "HomeBannerCell"
    @IBOutlet private weak var imageView: UIImageView!
    
    func configure(_ viewModel: HomeBannerCellViewModel){
        imageView.kf.setImage(with: URL(string: viewModel.bannerImageUrl))
    }
}

extension HomeBannerCell {
    static func bannerLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(165 / 393))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
