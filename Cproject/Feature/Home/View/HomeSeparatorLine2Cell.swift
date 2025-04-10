//
//  HomeSeparatorLine2Cell.swift
//  Cproject
//
//  Created by wodnd on 4/10/25.
//

import UIKit

struct HomeSeparatorLine2CellViewModel: Hashable {
    
}

final class HomeSeparatorLine2Cell: UICollectionViewCell {
    static let reusableId: String = "HomeSeparatorLine2Cell"
    
    func configure(_ viewModel: HomeSeparatorLine2CellViewModel){
        contentView.backgroundColor = CPColor.gray1
    }
}

extension HomeSeparatorLine2Cell {
    static func separatorLine2Layout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(11))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 13, leading: 0, bottom: 0, trailing: 0)
        
        return section
        
    }
}
