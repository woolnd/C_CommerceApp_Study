//
//  HomeCategoryCell.swift
//  Cproject
//
//  Created by wodnd on 4/10/25.
//

import UIKit

struct HomeCategoryCellViewModel: Hashable {
    let image: UIImage
    let title: String
    
    static let list: [HomeCategoryCellViewModel] = [
           .init(image: CPImage.category1Small, title: "식품"),
           .init(image: CPImage.category2Small, title: "생활용품"),
           .init(image: CPImage.category3Small, title: "패션"),
           .init(image: CPImage.category4Small, title: "뷰티"),
           .init(image: CPImage.category5Small, title: "디지털"),
           .init(image: CPImage.category6Small, title: "반려동물"),
           .init(image: CPImage.category7Small, title: "여행"),
           .init(image: CPImage.category8Small, title: "기타")
       ]
}

final class HomeCategoryCell: UICollectionViewCell {
    static let reusableId: String = "HomeCategoryCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(_ viewModel: HomeCategoryCellViewModel) {
        imageView.image = viewModel.image
        titleLabel.text = viewModel.title
    }
}

extension HomeCategoryCell {
    static func homeCategoryLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(54))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(160))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 20, leading: 20, bottom: 0, trailing: 20)
        section.interGroupSpacing = 20
        
        return section
        
    }
}
