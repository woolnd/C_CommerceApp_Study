//
//  PurchaseViewController.swift
//  Cproject
//
//  Created by wodnd on 4/19/25.
//

import UIKit
import Combine

final class PurchaseViewController: UIViewController {
    private var cancellables: Set<AnyCancellable> = []
    private var viewModel: PurchaseViewModel = PurchaseViewModel()
    private var rootView: PurchaseRootView = PurchaseRootView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        bindViewModel()
        viewModel.process(.loadData)
    }
    
    private func bindViewModel() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let viewModel = self?.viewModel.state.purchaseItems else { return }
                
                self?.rootView.setPurchaseItem(viewModel)
            }
            .store(in: &cancellables)
    }
}

#Preview{
    PurchaseViewController()
}
