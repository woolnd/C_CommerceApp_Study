//
//  OptionViewController.swift
//  Cproject
//
//  Created by wodnd on 4/15/25.
//

import UIKit
import SwiftUI

final class OptionViewController: UIViewController {
    
    let viewModel: OptionViewModel
    lazy var rootView: UIHostingController = UIHostingController(rootView: OptionRootView(viewModel: viewModel))
    
    // ✅ 여기가 새로 추가된 생성자
    init(currentOptionName: String?) {
        self.viewModel = OptionViewModel(currentOptionName: currentOptionName)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRootView()
        
    }
    
    private func addRootView() {
        addChild(rootView)
        view.addSubview(rootView.view)
        
        rootView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rootView.view.topAnchor.constraint(equalTo: view.topAnchor),
            rootView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rootView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rootView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
