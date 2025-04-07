//
//  HomeCouponBtnCell.swift
//  Cproject
//
//  Created by wodnd on 4/7/25.
//

import UIKit
import Combine

struct HomeCouponBtnViewModel: Hashable {
    enum CouponState {
        case enable
        case disable
    }
    
    var state: CouponState
}

final class HomeCouponBtnCell: UICollectionViewCell {
    static let reusableId: String = "HomeCouponBtnCell"
    
    private weak  var didTapCouponDownload: PassthroughSubject<Void, Never>?
    
    @IBOutlet weak var couponButton: UIButton! {
        didSet{
            couponButton.setImage(CPImage.btnActivate, for: .normal)
            couponButton.setImage(CPImage.btnComplete, for: .disabled)
        }
    }
    
    func configure(_ viewModel: HomeCouponBtnViewModel, _ didTapCouponDownload: PassthroughSubject<Void, Never>?) {
        self.didTapCouponDownload = didTapCouponDownload
        
        couponButton.isEnabled = switch viewModel.state {
        case .enable:
            true
        case .disable:
            false
        }
    }
    @IBAction func didTapCouponButton(_ sender: Any) {
        didTapCouponDownload?.send()
    }
}


extension HomeCouponBtnCell {
    static func couponBtnLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(37))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 28, leading: 22, bottom: 0, trailing: 22)
        
        return section
        
    }
}
