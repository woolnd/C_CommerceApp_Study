//
//  HomeViewController.swift
//  Cproject
//
//  Created by wodnd on 4/1/25.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?
    private var viewModel: HomeViewModel = HomeViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    enum Section: Int {
        case banner
        case horizontalProductItem
        case verticalProductItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingViewModel()
        viewModel.loadData()
        
        setDataSource()
        collectionView.collectionViewLayout = layout()
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        UICollectionViewCompositionalLayout { section, _ in
            switch Section(rawValue: section){
            case .banner:
                return HomeBannerCell.bannerLayout()
                
            case .horizontalProductItem:
                return HomeProductCell.horizontalProdectItemLayout()
                
            case .verticalProductItem:
                return HomeProductCell.verticalProductItemLayout()
                
            case .none: return nil
            }
        }
    }
    
    private func bindingViewModel() {
        viewModel.$bannerViewModels.receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applySnapShot()
            }.store(in: &cancellables)
        
        viewModel.$horizontalProductViewModels.receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applySnapShot()
            }.store(in: &cancellables)
        
        viewModel.$verticalProductViewModels.receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applySnapShot()
            }.store(in: &cancellables)
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [weak self] collectionView, indexPath, viewModel in
            
            switch Section(rawValue: indexPath.section){
            case .banner:
                return self?.bannerCell(collectionView, indexPath, viewModel)
            case .horizontalProductItem, .verticalProductItem:
                return self?.productCell(collectionView, indexPath, viewModel)
            case .none:
                return .init()
            }
        })
    }
    
    private func applySnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        if let bannerViewModels = viewModel.bannerViewModels{
            snapshot.appendSections([.banner])
            snapshot.appendItems(bannerViewModels, toSection: .banner)
        }
        
        if let horizontalProductViewModels = viewModel.horizontalProductViewModels{
            snapshot.appendSections([.horizontalProductItem])
            snapshot.appendItems(horizontalProductViewModels, toSection: .horizontalProductItem)
        }
        
        
        if let verticalProductViewModels = viewModel.verticalProductViewModels{
            snapshot.appendSections([.verticalProductItem])
            snapshot.appendItems(verticalProductViewModels, toSection: .verticalProductItem)
        }
        
        dataSource?.apply(snapshot)
    }
    
    private func bannerCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeBannerCellViewModel else {
            return .init()
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBannerCell", for: indexPath) as? HomeBannerCell else {
            return UICollectionViewCell()
        }
        cell.configure(viewModel)
        return cell
    }
    
    private func productCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeProductCellViewModel else {
            return .init()
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeProductCell", for: indexPath) as? HomeProductCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(viewModel)
        return cell
    }
}

#Preview{
    UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
}
