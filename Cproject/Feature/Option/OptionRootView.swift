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
        Text("옵션 화면")
    }
}

#Preview {
    OptionRootView(viewModel: OptionViewModel())
}
