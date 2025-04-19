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
    private var scrollViewConstraints: [NSLayoutConstraint]?
    private var titleLabelConstraints: [NSLayoutConstraint]?
    private var purchaseItemStackViewConstraints: [NSLayoutConstraint]?
    private var purchaseButtonConstraints: [NSLayoutConstraint]?
    
    private var scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var containerView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "주문 상품 목록"
        label.font = CPFont.UIKit.m17
        label.textColor = CPColor.UIKit.bk
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var purchaseItemStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 7
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var purchaseButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("결제하기", for: .normal)
        button.setTitleColor(CPColor.UIKit.wh, for: .normal)
        button.layer.backgroundColor = CPColor.UIKit.keyColorBlue.cgColor
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubView()
        bindViewModel()
        viewModel.process(.loadData)
    }
    
    override func updateViewConstraints() {
        if scrollViewConstraints == nil {
            let constraints = [
                scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: purchaseButton.topAnchor),
                
                containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
            scrollViewConstraints = constraints
        }
        
        if titleLabelConstraints == nil, let superView = titleLabel.superview {
            let constraints = [
                titleLabel.topAnchor.constraint(equalTo: superView.topAnchor, constant: 33),
                titleLabel.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 33),
                titleLabel.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -33),
            ]
            
            NSLayoutConstraint.activate(constraints)
            titleLabelConstraints = constraints
        }
        
        if purchaseItemStackViewConstraints == nil, let superView = purchaseItemStackView.superview {
            let constraints = [
                purchaseItemStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 19),
                purchaseItemStackView.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 20),
                purchaseItemStackView.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -20),
                purchaseItemStackView.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -33)
            ]
            
            NSLayoutConstraint.activate(constraints)
            purchaseItemStackViewConstraints = constraints
        }
        
        if purchaseButtonConstraints == nil{
            let constraints = [
                purchaseButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                purchaseButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                purchaseButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
                purchaseButton.heightAnchor.constraint(equalToConstant: 50)
            ]
            
            NSLayoutConstraint.activate(constraints)
            purchaseButtonConstraints = constraints
        }
        
        super.updateViewConstraints()
    }
    
    private func addSubView() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(purchaseItemStackView)
        view.addSubview(purchaseButton)
    }
    
    private func bindViewModel() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.purchaseItemStackView.arrangedSubviews.forEach {
                    $0.removeFromSuperview()
                }
                
                self?.viewModel.state.purchaseItems?.forEach {
                    self?.purchaseItemStackView.addArrangedSubview(PurchaseSelectedItemView(viewModel: $0))
                }
            }
            .store(in: &cancellables)
    }
}

#Preview{
    PurchaseViewController()
}
