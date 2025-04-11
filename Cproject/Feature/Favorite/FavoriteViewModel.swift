//
//  FavoriteViewModel.swift
//  Cproject
//
//  Created by wodnd on 4/11/25.
//

import Foundation

final class FavoriteViewModel {
    enum Action {
        case getFavoriteFromAPI
        case getFavoriteSuccess(FavoritesResponse)
        case getFavoriteFailure(Error)
        case didTapPurchaseButton
    }
    
    final class State{
        @Published var tableViewModel: [FavoriteItemTableViewCellViewModel]?
    }
    
    private(set) var state: State = State()
    
    func process(_ action: Action){
        switch action{
        case .getFavoriteFromAPI:
            getFavoriteFromAPI()
        case .getFavoriteSuccess(let favoriteResponse):
            translateFavoriteItemViewModel(favoriteResponse)
        case .getFavoriteFailure(let error):
            print(error)
        case .didTapPurchaseButton:
            break
        }
    }
}

extension FavoriteViewModel {
    private func getFavoriteFromAPI() {
        Task {
            do{
                let response = try await NetworkService.shared.getFavoriteData()
                process(.getFavoriteSuccess(response))
            } catch{
                process(.getFavoriteFailure(error))
            }
        }
    }
    
    private func translateFavoriteItemViewModel(_ response: FavoritesResponse){
        state.tableViewModel = response.favorites.map{
            FavoriteItemTableViewCellViewModel(imageUrl: $0.imageUrl, productName: $0.title, productPrice: $0.discountPrice.moneyString)
        }
    }
}
