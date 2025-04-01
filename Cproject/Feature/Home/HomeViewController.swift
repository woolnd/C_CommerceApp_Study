//
//  HomeViewController.swift
//  Cproject
//
//  Created by wodnd on 4/1/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?
    
    enum Section: Int {
        case banner
        case horizontalProductItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, viewModel in
            
            switch Section(rawValue: indexPath.section){
            case .banner:
                guard let viewModel = viewModel as? HomeBannerCellViewModel else {
                    return .init()
                }
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBannerCell", for: indexPath) as? HomeBannerCell else {
                    return UICollectionViewCell()
                }
                
                cell.configure(viewModel)
                return cell
            case .horizontalProductItem:
                guard let viewModel = viewModel as? HomeProductCellViewModel else {
                    return .init()
                }
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeProductCell", for: indexPath) as? HomeProductCell else {
                    return UICollectionViewCell()
                }
                
                cell.configure(viewModel)
                return cell
            case .none:
                return .init()
            }
            
           
            
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.banner])
        snapshot.appendItems([
            HomeBannerCellViewModel(bannerImage: .slide1),
            HomeBannerCellViewModel(bannerImage: .slide2),
            HomeBannerCellViewModel(bannerImage: .slide3)], toSection: .banner)
        
        snapshot.appendSections([.horizontalProductItem])
        snapshot.appendItems([
            HomeProductCellViewModel(imageUlrString: "", title: "playstation1", reasonDiscountString: "쿠폰 할인", originalPriceString: "100000", discountPriceString: "80000"),
            HomeProductCellViewModel(imageUlrString: "", title: "playstation2", reasonDiscountString: "쿠폰 할인", originalPriceString: "100000", discountPriceString: "80000"),
            HomeProductCellViewModel(imageUlrString: "", title: "playstation3", reasonDiscountString: "쿠폰 할인", originalPriceString: "100000", discountPriceString: "80000"),
            HomeProductCellViewModel(imageUlrString: "", title: "playstation4", reasonDiscountString: "쿠폰 할인", originalPriceString: "100000", discountPriceString: "80000"),
            HomeProductCellViewModel(imageUlrString: "", title: "playstation5", reasonDiscountString: "쿠폰 할인", originalPriceString: "100000", discountPriceString: "80000")], toSection: .horizontalProductItem)
        
        dataSource?.apply(snapshot)
        
        collectionView.collectionViewLayout = layout()
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        UICollectionViewCompositionalLayout { section, _ in
            switch Section(rawValue: section){
            case .banner:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(165 / 393))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                return section
                
            case .horizontalProductItem:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(117), heightDimension: .estimated(224))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
                section.contentInsets = .init(top: 20, leading: 33, bottom: 0, trailing: 33)
                section.interGroupSpacing = 14
                
                return section
                
            case .none: return nil
            }
        }
        
        
    }
}

#Preview{
    UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
}
