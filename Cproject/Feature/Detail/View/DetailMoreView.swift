//
//  DetailMoreView.swift
//  Cproject
//
//  Created by wodnd on 4/12/25.
//

import SwiftUI

final class DetailMoreViewModel: ObservableObject {
    
}

struct DetailMoreView: View {
    @ObservedObject var viewModel: DetailMoreViewModel
    var onMoreTapped: () -> Void
    
    var body: some View {
        Button {
            onMoreTapped()
        } label: {
            HStack(alignment: .center, spacing: 10) {
                Text("상폼정보 더보기")
                    .font(CPFont.SwiftUI.b17)
                    .foregroundStyle(CPColor.SwiftUI.keyColorBlue)
                
                Image(.down)
                    .foregroundStyle(CPColor.SwiftUI.gray7)
            }
            .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
            .border(CPColor.SwiftUI.keyColorBlue, width: 1)
        }

    }
}

#Preview {
    DetailMoreView(viewModel: DetailMoreViewModel(), onMoreTapped: {})
}
