//
//  OptionViewModel.swift
//  Cproject
//
//  Created by wodnd on 4/15/25.
//

import Foundation
import FirebaseFirestore
import Combine

final class OptionViewModel: ObservableObject {
    struct State{
        var optionDetail: [OptionDetailViewModel]?
        var isLoading: Bool = false
        var currentOptionName: String?
    }
    
    enum Action{
        case loadData
        case loading(Bool)
        case getDataFailure(Error)
        case getDataSuccess(OptionDetailResponse)
        case didTapOption(OptionDetailViewModel)
    }
    
    @Published private(set) var state: State = State()
    private var loadDataTask: Task<Void, Never>?
    
    // ✅ 여기서 초기값 전달
    init(currentOptionName: String?) {
        state.currentOptionName = currentOptionName
    }
    
    func process(_ action: Action) {
        switch action {
        case .loadData:
            loadData()
        case let .loading(isLoading):
            Task{ await toggleLoading(isLoading) }
        case .didTapOption:
            break
        case let .getDataFailure(error):
            print(error)
        case let .getDataSuccess(response):
            Task{
                await transformResponse(response)
            }
        }
    }
    
    deinit{
        loadDataTask?.cancel()
    }
}

extension OptionViewModel {
    private func loadData() {
        loadDataTask = Task{
            await MainActor.run {
                process(.loading(true))
            }
            
            do {
                let db = Firestore.firestore()
                let docRef = db.collection("OptionDetail").document("2")
                
                let snapshot = try await docRef.getDocument()
                guard let response = try? snapshot.data(as: OptionDetailResponse.self) else {
                    throw NSError(domain: "DecodingError", code: -1)
                }
                process(.getDataSuccess(response))
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
    private func transformResponse(_ response: OptionDetailResponse) async {
        state.optionDetail = response.option.map{
            OptionDetailViewModel(name: $0.name, imageUrl: $0.imageUrl, price: $0.price)
        }
    }
    
    @MainActor
    private func didTapOption(_ viewModel: OptionDetailViewModel)async{
        
    }
}
