//
//  OptionViewController.swift
//  Cproject
//
//  Created by wodnd on 4/15/25.
//

import UIKit
import SwiftUI

final class OptionViewController: UIViewController {

    let viewModel: OptionViewModel = OptionViewModel()
    lazy var rootView: UIHostingController = UIHostingController(rootView: OptionRootView(viewModel: viewModel))
    
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
