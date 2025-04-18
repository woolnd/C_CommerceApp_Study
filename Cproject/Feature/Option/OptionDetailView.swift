//
//  OptionDetailView.swift
//  Cproject
//
//  Created by wodnd on 4/18/25.
//

import SwiftUI
import Kingfisher

final class OptionDetailViewModel: ObservableObject, Identifiable {
    let id = UUID() // 유일한 식별자 추가
    init(name: String, imageUrl: String, price: String) {
        self.name = name
        self.imageUrl = imageUrl
        self.price = price
    }
    
    @Published var name: String
    @Published var imageUrl: String
    @Published var price: String
}

struct OptionDetailView: View {
    
    var viewModel: [OptionDetailViewModel]
    @State var tapOptionName: String
    
    
    var body: some View {
        ScrollView(.vertical){
            LazyVStack(spacing: 0){
                ForEach(viewModel, id:\.id){ detail in
                    Button {
                        tapOptionName = detail.name
                    } label: {
                        HStack(spacing: 31) {
                            VStack(alignment: .leading, spacing: 7) {
                                Text(detail.name)
                                    .font(CPFont.SwiftUI.b14)
                                    .foregroundStyle(CPColor.SwiftUI.bk)
                                
                                Text(detail.price)
                                    .font(CPFont.SwiftUI.b20)
                                    .foregroundStyle(CPColor.SwiftUI.keyColorRed)
                                
                                HStack(spacing: 0) {
                                    Text("무료배송")
                                        .font(CPFont.SwiftUI.m12)
                                        .foregroundStyle(CPColor.SwiftUI.gray7)
                                    
                                    Spacer()
                                    
                                    Text("품절임박")
                                        .font(CPFont.SwiftUI.m12)
                                        .foregroundStyle(CPColor.SwiftUI.keyColorBlue)
                                }
                            }
                            
                            KFImage(URL(string: detail.imageUrl))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 68, height: 68)
                        }
                        .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 47))
                        .background {
                            detail.name == tapOptionName ? CPColor.SwiftUI.gray1 : nil
                        }
                    }

                }
            }
        }
    }
}

#Preview {
    OptionDetailView(viewModel: [OptionDetailViewModel(name: "코랄", imageUrl: "https://picsum.photos/id/1/500/500", price: "139,000원"), OptionDetailViewModel(name: "파랑", imageUrl: "https://picsum.photos/id/1/500/500", price: "139,000원"), OptionDetailViewModel(name: "초록", imageUrl: "https://picsum.photos/id/1/500/500", price: "139,000원")], tapOptionName: "코랄")
}
