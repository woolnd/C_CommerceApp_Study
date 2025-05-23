//
//  HomeViewController.swift
//  Cproject
//
//  Created by wodnd on 4/1/25.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
    
    private lazy var dataSource: DataSource = setDataSource()
    private var viewModel: HomeViewModel = HomeViewModel()
    private var cancellables: Set<AnyCancellable> = []
    private var currentSection: [Section] {
        dataSource.snapshot().sectionIdentifiers as [Section]
    }
    
    private var didTapCouponDownload: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    
    private enum Section: Int {
        case banner
        case horizontalProductItem
        case categorySeparte
        case categoryItem
        case separteLine1
        case couponBtn
        case verticalProductItem
        case separteLine2
        case theme
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingViewModel()
        collectionView.collectionViewLayout = layout()
        collectionView.delegate = self
        viewModel.process(.loadData)
        viewModel.process(.loadCoupon)
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        UICollectionViewCompositionalLayout { [weak self] section, _ in
            switch self?.currentSection[section] {
            case .banner:
                return HomeBannerCell.bannerLayout()
            case .horizontalProductItem:
                return HomeProductCell.horizontalProdectItemLayout()
            case .couponBtn:
                return HomeCouponBtnCell.couponBtnLayout()
            case .verticalProductItem:
                return HomeProductCell.verticalProductItemLayout()
            case .separteLine1, .separteLine2:
                return HomeSeparatorLineCell.separatorLineLayout()
            case .theme:
                return HomeThemeCell.themeLayout()
            case .categoryItem:
                return HomeCategoryCell.homeCategoryLayout()
            case .categorySeparte:
                return HomeCategorySeparatorLineCell.categorySeparatorLineLayout()
            case .none: return nil
            }
        }
    }
    
    private func bindingViewModel() {
        viewModel.state.$collectionViewModels.receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applySnapShot()
            }.store(in: &cancellables)
        
        didTapCouponDownload.receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.viewModel.process(.didTapCouponButton)
            }.store(in: &cancellables)
    }
    
    private func setDataSource() -> DataSource {
        let dataSource: DataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [weak self] collectionView, indexPath, viewModel in
            
            switch self?.currentSection[indexPath.section]{
            case .banner:
                return self?.bannerCell(collectionView, indexPath, viewModel)
            case .horizontalProductItem, .verticalProductItem:
                return self?.productCell(collectionView, indexPath, viewModel)
            case .categoryItem:
                return self?.categoryCell(collectionView, indexPath, viewModel)
            case .couponBtn:
                return self?.couponCell(collectionView, indexPath, viewModel)
            case .separteLine1:
                return self?.separteCell(collectionView, indexPath, viewModel)
            case .separteLine2:
                return self?.separte2Cell(collectionView, indexPath, viewModel)
            case .categorySeparte:
                return self?.categorySeparteCell(collectionView, indexPath, viewModel)
            case .theme:
                return self?.themeCell(collectionView, indexPath, viewModel)
            case .none:
                return .init()
            }
        })
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader, let viewModel = self.viewModel.state.collectionViewModels.themeViewModels?.header else { return nil }
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeThemeHeaderView.resuableId, for: indexPath) as? HomeThemeHeaderView
            
            headerView?.configure(viewModel)
            return headerView
        }
        return dataSource
    }
    
    private func applySnapShot() {
        var snapshot: Snapshot = Snapshot()
        if let bannerViewModels = viewModel.state.collectionViewModels.bannerViewModels{
            snapshot.appendSections([.banner])
            snapshot.appendItems(bannerViewModels, toSection: .banner)
        }
        
        if let horizontalProductViewModels = viewModel.state.collectionViewModels.horizontalProductViewModels{
            snapshot.appendSections([.horizontalProductItem])
            snapshot.appendItems(horizontalProductViewModels, toSection: .horizontalProductItem)
        }
        
        if let cateViewModels = viewModel.state.collectionViewModels.categoryViewModels {
            
            let categorylist = HomeCategoryCellViewModel.list
            
            snapshot.appendSections([.categorySeparte])
            snapshot.appendItems(viewModel.state.collectionViewModels.categorySeparateLineViewModels, toSection: .categorySeparte)
            
            snapshot.appendSections([.categoryItem])
            snapshot.appendItems(categorylist, toSection: .categoryItem)
            
            snapshot.appendSections([.separteLine1])
            snapshot.appendItems(viewModel.state.collectionViewModels.separateLine1ViewModels, toSection: .separteLine1)
        }
        
         
        if let couponViewModels = viewModel.state.collectionViewModels.couponSate {
            
            snapshot.appendSections([.couponBtn])
            snapshot.appendItems(couponViewModels, toSection: .couponBtn)
        }
        
        if let verticalProductViewModels = viewModel.state.collectionViewModels.verticalProductViewModels{
            snapshot.appendSections([.verticalProductItem])
            snapshot.appendItems(verticalProductViewModels, toSection: .verticalProductItem)
        }
        
        if let themeViewModels = viewModel.state.collectionViewModels.themeViewModels?.items{
            snapshot.appendSections([.separteLine2])
            snapshot.appendItems(viewModel.state.collectionViewModels.separateLine2ViewModels, toSection: .separteLine2)
            
            snapshot.appendSections([.theme])
            snapshot.appendItems(themeViewModels, toSection: .theme)
        }
        
        dataSource.apply(snapshot)
    }
    
    private func bannerCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeBannerCellViewModel else {
            return .init()
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBannerCell.reusableId, for: indexPath) as? HomeBannerCell else {
            return UICollectionViewCell()
        }
        cell.configure(viewModel)
        return cell
    }
    
    private func productCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeProductCellViewModel else {
            return .init()
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeProductCell.reusableId, for: indexPath) as? HomeProductCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(viewModel)
        return cell
    }
    
    private func couponCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeCouponBtnViewModel else {
            return .init()
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCouponBtnCell.reusableId, for: indexPath) as? HomeCouponBtnCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(viewModel, didTapCouponDownload)
        return cell
    }
    
    private func separteCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeSeparatorLineCellViewModel else {
            return .init()
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSeparatorLineCell.reusableId, for: indexPath) as? HomeSeparatorLineCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(viewModel)
        return cell
    }
    
    private func separte2Cell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeSeparatorLine2CellViewModel else {
            return .init()
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSeparatorLine2Cell.reusableId, for: indexPath) as? HomeSeparatorLine2Cell else {
            return UICollectionViewCell()
        }
        
        cell.configure(viewModel)
        return cell
    }
    
    private func categorySeparteCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeCategorySeparatorLineCellViewModel else {
            return .init()
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategorySeparatorLineCell.reusableId, for: indexPath) as? HomeCategorySeparatorLineCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(viewModel)
        return cell
    }
    
    private func themeCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
       
        guard let viewModel = viewModel as? HomeThemeCellViewModel,
              let cell: HomeThemeCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeThemeCell.resuableId, for: indexPath) as? HomeThemeCell else { return .init() }
        
        cell.configure(viewModel)
        return cell
    }
    
    private func categoryCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeCategoryCellViewModel else {
            return .init()
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCell.reusableId, for: indexPath) as? HomeCategoryCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(viewModel)
        return cell
    }

    @IBAction func favoriteButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Favorite", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FavoriteViewController") as! FavoriteViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch currentSection[indexPath.section] {
        case .banner:
            break
        case .categoryItem, .categorySeparte, .separteLine1, .separteLine2:
            break
        case .couponBtn:
            break
        case .horizontalProductItem, .verticalProductItem:
            let storyboard = UIStoryboard(name: "Detail", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            
            navigationController?.pushViewController(vc, animated: true)
        case .theme:
            break
        }
    }
}

#Preview{
    UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
}
 
