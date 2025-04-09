//
//  HomeThemeCell.swift
//  Cproject
//
//  Created by wodnd on 4/9/25.
//

import UIKit
import Kingfisher

struct HomeThemeCellViewModel: Hashable {
    let imageUrl: String
}

final class HomeThemeCell: UICollectionViewCell {
    static let resuableId: String = "HomeThemeCell"
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(_ viewModel: HomeThemeCellViewModel) {
        imageView.kf.setImage(with: URL(string: viewModel.imageUrl))
    }
}

extension HomeThemeCell {
    static func themeLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupFractionalWidth: CGFloat = 0.7
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupFractionalWidth), heightDimension: .fractionalWidth((142/286) * groupFractionalWidth))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 16
        section.contentInsets = .init(top: 35, leading: 0, bottom: 0, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(65  ))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [header]
        return section
    }
}
