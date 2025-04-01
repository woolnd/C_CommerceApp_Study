//
//  HomeBannerCell.swift
//  Cproject
//
//  Created by wodnd on 4/1/25.
//

import UIKit

class HomeBannerCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(_ image: UIImage){
        imageView.image = image
    }
}
