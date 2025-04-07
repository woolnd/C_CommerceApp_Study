//
//  HomeViewModel.swift
//  Cproject
//
//  Created by wodnd on 4/4/25.
//

import Foundation
import Combine

final class HomeViewModel{
    enum Action{
        case loadData
        case loadCoupon
        case getDataSuccess(HomeResponse)
        case getDataFailure(Error)
        case getCouponSuccess(Bool)
        case didTapCouponButton
    }
    
    final class State {
        struct CollectionViewModels {
            var bannerViewModels: [HomeBannerCellViewModel]?
            var horizontalProductViewModels: [HomeProductCellViewModel]?
            var verticalProductViewModels: [HomeProductCellViewModel]?
            var couponSate: [HomeCouponBtnViewModel]?
            var separateLine1ViewModels: [HomeSeparatorLineCellViewModel] = [HomeSeparatorLineCellViewModel()]
            var separateLine2ViewModels: [HomeSeparatorLineCellViewModel] = [HomeSeparatorLineCellViewModel()]
        }
        
        @Published var collectionViewModels: CollectionViewModels = CollectionViewModels()
    }
    
    private(set) var state: State = State()
    private var loadDataTask: Task<Void, Never>?
    private let couponKey: String = "CouponState"
    
    func process(_ action: Action){
        switch action {
        case .loadData:
            loadData()
        case .loadCoupon:
            loadCoupon()
        case let .getDataSuccess(response):
            transformResponse(response)
        case let .getDataFailure(error):
            print("network error: \(error)")
        case let .getCouponSuccess(state):
            Task { await transformCoupon(state) }
        case .didTapCouponButton:
            downloadCoupon()
        }
    }
    
    deinit {
        loadDataTask?.cancel()
    }
}

extension HomeViewModel {
    private func loadData() {
        loadDataTask = Task{
            do {
                let response =  try await NetworkService().getHomeData()
                process(.getDataSuccess(response))
            } catch {
                process(.getDataFailure(error))
            }
        }
    }
    
    private func loadCoupon() {
        let couponState: Bool = UserDefaults.standard.bool(forKey: couponKey)
        process(.getCouponSuccess(couponState))
    }
    
    private func transformResponse(_ response: HomeResponse){
        Task { await transformBanner(response) }
        Task{ await transformHorizontalProduct(response) }
        Task{ await transformVerticalProduct(response) }
    }
    
    @MainActor
    private func transformBanner(_ response: HomeResponse) async {
        state.collectionViewModels.bannerViewModels = response.banners.map {
            HomeBannerCellViewModel(bannerImageUrl: $0.imageUrl)
        }
    }
    
    @MainActor
    private func transformHorizontalProduct(_ response: HomeResponse) async {
        state.collectionViewModels.horizontalProductViewModels = homeProductCellViewModel(response.horizontalProducts)
    }
    
    @MainActor
    private func transformVerticalProduct(_ response: HomeResponse) async {
        state.collectionViewModels.verticalProductViewModels = homeProductCellViewModel(response.verticalProducts)
    }
    
    private func homeProductCellViewModel(_ product: [Product]) -> [HomeProductCellViewModel] {
        return product.map {
            HomeProductCellViewModel(imageUlrString: $0.imageUrl, title: $0.title, reasonDiscountString: $0.discount, originalPriceString: $0.originalPrice.moneyString, discountPriceString: $0.discountPrice.moneyString)
        }
    }
    
    @MainActor
    private func transformCoupon(_ couponState: Bool) async {
        state.collectionViewModels.couponSate = [.init(state: couponState ? .disable : .enable)]
    }
    
    private func downloadCoupon() {
        UserDefaults.standard.set(true, forKey: couponKey)
        process(.loadCoupon)
    }
}
