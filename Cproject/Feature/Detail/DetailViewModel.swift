//
//  DetailViewModel.swift
//  Cproject
//
//  Created by wodnd on 4/12/25.
//

import Foundation
import FirebaseFirestore
import Combine

final class DetailViewModel: ObservableObject {
    struct State {
        var isError: String?
        var isLoading: Bool = false
        var banners: DetailBannerViewModel?
        var rate: DetailRateViewModel?
        var title: String?
        var option: DetailOptionViewModel?
        var price: DetailPriceViewModel?
        var mainImageUrls: [String]?
        var more: DetailMoreViewModel?
        var purchase: DetailPurchaseViewModel?
    }
    
    enum Action {
        case loadData
        case loading(Bool)
        case getDataSucess(ProductDetailResponse)
        case getDataFailure(Error)
        case didTapChangeOption
        case didTapMore
        case didTapFavorite
        case didTapPurchase
    }
    
    @Published private(set) var state: State = State()
    private(set) var showOptionViewController = PassthroughSubject<String?, Never>()
    private var loadDataTask: Task<Void, Never>?
    private var isFavorite: Bool = false
    private var needShowMore: Bool = true
    
    func process(_ action: Action) {
        switch action {
            
        case .loadData:
            loadData()
        case let .loading(isLoading):
            Task{ await toggleLoading(isLoading) }
        case let .getDataSucess(response):
            print(response)
            Task{
                await transformProductDetailResponse(response)
            }
            
        case let .getDataFailure(error):
            Task { await getDataError(error) }
        case .didTapChangeOption:
            let selectedOptionName = state.option?.name
            showOptionViewController.send(selectedOptionName)
        case .didTapMore:
            Task{ await toggleMore () }
        case .didTapFavorite:
            Task{ await toggleFavorite() }
        case .didTapPurchase:
            break
        }
    }
    
    deinit{
        loadDataTask?.cancel()
    }
}

extension DetailViewModel {
//    private func loadData() {
//        loadDataTask = Task {
//            defer {
//                process(.loading(false))
//            }
//            do {
//                process(.loading(true))
//                let response = try await NetworkService.shared.getProductDetailData()
//                process(.getDataSucess(response))
//            } catch {
//                process(.getDataFailure(error))
//            }
//        }
//    }
    private func loadData() {
        loadDataTask = Task {
            await MainActor.run {
                process(.loading(true))
            }
            do {
                let db = Firestore.firestore()
                let docRef = db.collection("ProductDetail").document("sample1")

                let snapshot = try await docRef.getDocument()
                guard let response = try? snapshot.data(as: ProductDetailResponse.self) else {
                    throw NSError(domain: "DecodingError", code: -1)
                }

                process(.getDataSucess(response))
            } catch {
                process(.getDataFailure(error))
            }
            
            await MainActor.run {
                process(.loading(false))
            }
        }
    }
    
    @MainActor
    private func toggleLoading(_ isLoading: Bool) async {
        state.isLoading = isLoading
    }
    
    @MainActor
    private func toggleFavorite() async {
        isFavorite.toggle()
        state.purchase = DetailPurchaseViewModel(isFavorite: isFavorite)
    }
    
    @MainActor
    private func toggleMore() async {
        needShowMore = false
        state.more = needShowMore ? DetailMoreViewModel() : nil
    }
    
    @MainActor
    private func transformProductDetailResponse(_ response: ProductDetailResponse) async {
        state.isError = nil
        state.banners = DetailBannerViewModel(imageUrls: response.bannerImages)
        state.rate = DetailRateViewModel(rate: response.product.rate)
        state.title = response.product.name
        state.option = DetailOptionViewModel(type: response.option.type, name: response.option.name, imageUrl: response.option.image)
        state.price = DetailPriceViewModel(discountRate: "\(response.product.discountPercent)%", originalPrice: response.product.originalPrice.moneyString, currentPrice: response.product.discountPrice.moneyString, shippingType: "무료배송")
        state.mainImageUrls = response.detailImages
        state.more = needShowMore ? DetailMoreViewModel() : nil
        state.purchase = DetailPurchaseViewModel(isFavorite: isFavorite)
    }
    
    @MainActor
    private func getDataError(_ error: Error){
        state.isError = "에러가 발생했습니다. \(error.localizedDescription)"
    }
}
