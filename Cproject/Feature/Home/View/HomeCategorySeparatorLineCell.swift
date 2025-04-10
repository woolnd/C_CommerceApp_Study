//
//  HomeCategorySeparatorLineCell.swift
//  Cproject
//
//  Created by wodnd on 4/10/25.
//

import UIKit

struct HomeCategorySeparatorLineCellViewModel: Hashable {
    
}

final class HomeCategorySeparatorLineCell: UICollectionViewCell {
    static let reusableId: String = "HomeCategorySeparatorLineCell"
    
    func configure(_ viewModel: HomeCategorySeparatorLineCellViewModel){
        contentView.backgroundColor = CPColor.gray1
    }
}

extension HomeCategorySeparatorLineCell {
    static func categorySeparatorLineLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 13, leading: 0, bottom: 0, trailing: 0)
        
        return section
        
    }
}
