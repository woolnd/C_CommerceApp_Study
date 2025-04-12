//
//  HomeSpearateLineCell.swift
//  Cproject
//
//  Created by wodnd on 4/7/25.
//

import UIKit

struct HomeSeparatorLineCellViewModel: Hashable {
    
}

final class HomeSeparatorLineCell: UICollectionViewCell {
    static let reusableId: String = "HomeSeparatorLineCell"
    
    func configure(_ viewModel: HomeSeparatorLineCellViewModel){
        contentView.backgroundColor = CPColor.UIKit.gray1
    }
}

extension HomeSeparatorLineCell {
    static func separatorLineLayout() -> NSCollectionLayoutSection {
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
