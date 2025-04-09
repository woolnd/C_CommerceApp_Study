//
//  HomeThemeHeaderView.swift
//  Cproject
//
//  Created by wodnd on 4/9/25.
//

import UIKit

struct HomeThemeHeaderViewModel {
    var headerText: String
}

final class HomeThemeHeaderView: UICollectionReusableView {
    static let resuableId: String = "HomeThemeHeaderView"
    
    @IBOutlet weak var headerLabel: UILabel!
    func configure(_ viewModel: HomeThemeHeaderViewModel) {
        headerLabel.text = viewModel.headerText
    }
}
