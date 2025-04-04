//
//  HomeViewModel.swift
//  Cproject
//
//  Created by wodnd on 4/4/25.
//

import Foundation
import Combine

class HomeViewModel{
    @Published var bannerViewModels: [HomeBannerCellViewModel]?
    @Published var horizontalProductViewModels: [HomeProductCellViewModel]?
    @Published var verticalProductViewModels: [HomeProductCellViewModel]?
    
    private var loadDataTask: Task<Void, Never>?
    
    func loadData() {
        loadDataTask = Task{
            do {
                let response =  try await NetworkService().getHomeData()
                
                Task { await transformBanner(response) }
               
                Task{ await transformHorizontalProduct(response) }
                
                Task{ await transformVerticalProduct(response) }
                
            } catch {
                print("network error: \(error)")
            }
        }
    }
    
    deinit {
        loadDataTask?.cancel()
    }
    
    @MainActor
    private func transformBanner(_ response: HomeResponse) async {
        bannerViewModels = response.banners.map {
            HomeBannerCellViewModel(bannerImageUrl: $0.imageUrl)
        }
    }
    
    @MainActor
    private func transformHorizontalProduct(_ response: HomeResponse) async {
        horizontalProductViewModels = response.horizontalProducts.map {
            HomeProductCellViewModel(imageUlrString: $0.imageUrl, title: $0.title, reasonDiscountString: $0.discount, originalPriceString: "\($0.originalPrice)", discountPriceString: "\($0.discountPrice)")
        }
    }
    
    @MainActor
    private func transformVerticalProduct(_ response: HomeResponse) async {
        verticalProductViewModels = response.verticalProducts.map {
            HomeProductCellViewModel(imageUlrString: $0.imageUrl, title: $0.title, reasonDiscountString: $0.discount, originalPriceString: "\($0.originalPrice)", discountPriceString: "\($0.discountPrice)")
        }
    }
}
