//
//  OptionRootView.swift
//  Cproject
//
//  Created by wodnd on 4/15/25.
//

import SwiftUI

struct OptionRootView: View {
    @ObservedObject var viewModel: OptionViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.state.isLoading {
                
            } else {
                optionList
            }
        }
        .onAppear(){
            viewModel.process(.loadData)
        }
        
    }
    
    @ViewBuilder
    var optionList: some View {
        if let optionViewModel = viewModel.state.optionDetail{
            OptionDetailView(viewModel: optionViewModel, tapOptionName: viewModel.state.currentOptionName ?? "파랑")
        }

    }
}

#Preview {
    OptionRootView(viewModel: OptionViewModel(currentOptionName: "코랄"))
}
