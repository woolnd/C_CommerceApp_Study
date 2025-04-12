//
//  DetailBannerView.swift
//  Cproject
//
//  Created by wodnd on 4/12/25.
//

import SwiftUI
import Kingfisher

final class DetailBannerViewModel: ObservableObject{
    init(imageUrls: [String]) {
        self.imageUrls = imageUrls
    }
    
    @Published var imageUrls: [String]
}

struct DetailBannerView: View {
    @ObservedObject var viewModel: DetailBannerViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(viewModel.imageUrls, id: \.self) { imageUrl in
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        .scrollTargetBehavior(.paging)
        .scrollIndicators(.never)
       
    }
}

#Preview {
    DetailBannerView(viewModel: DetailBannerViewModel(
        imageUrls: ["https://picsum.photos/id/1/500/500",
                    "https://picsum.photos/id/2/500/500",
                    "https://picsum.photos/id/3/500/500",
                    "https://picsum.photos/id/4/500/500",
                    "https://picsum.photos/id/5/500/500"
                   ]))
}
