//
//  HomeViewModel.swift
//  Cproject
//
//  Created by wodnd on 4/4/25.
//

import Foundation
import Combine

class HomeViewModel{
    enum Action{
        case loadData
        case getDataSuccess(HomeResponse)
        case getDataFailure(Error)
    }
    
    final class State {
        struct CollectionViewModels {
            var bannerViewModels: [HomeBannerCellViewModel]?
            var horizontalProductViewModels: [HomeProductCellViewModel]?
            var verticalProductViewModels: [HomeProductCellViewModel]?
        }
        
        @Published var collectionViewModels: CollectionViewModels = CollectionViewModels()
    }
    
    private(set) var state: State = State()
    private var loadDataTask: Task<Void, Never>?
    
    func process(_ action: Action){
        switch action {
        case .loadData:
            loadData()
        case let .getDataSuccess(response):
            transformResponse(response)
        case let .getDataFailure(error):
            print("network error: \(error)")
        }
    }
    
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
    
    deinit {
        loadDataTask?.cancel()
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
}
