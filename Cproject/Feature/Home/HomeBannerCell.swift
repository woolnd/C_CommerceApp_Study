//
//  HomeBannerCell.swift
//  Cproject
//
//  Created by wodnd on 4/1/25.
//

import UIKit

struct HomeBannerCellViewModel: Hashable{
    let bannerImage: UIImage
}

class HomeBannerCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(_ viewModel: HomeBannerCellViewModel){
        imageView.image = viewModel.bannerImage
    }
}
