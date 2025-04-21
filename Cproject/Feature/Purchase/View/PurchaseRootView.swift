//
//  PurchaseRootView.swift
//  Cproject
//
//  Created by wodnd on 4/21/25.
//

import UIKit

final class PurchaseRootView: UIView {

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
    
    override func updateConstraints() {
        if scrollViewConstraints == nil {
            let constraints = [
                scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
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
                purchaseButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
                purchaseButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
                purchaseButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -32),
                purchaseButton.heightAnchor.constraint(equalToConstant: 50)
            ]
            
            NSLayoutConstraint.activate(constraints)
            purchaseButtonConstraints = constraints
        }
        
        super.updateConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubView()
    }
    
    private func addSubView() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(purchaseItemStackView)
        addSubview(purchaseButton)
    }
    
    func setPurchaseItem(_ viewModel: [PurchaseSelectedItemViewModel]){
        purchaseItemStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        viewModel.forEach {
            purchaseItemStackView.addArrangedSubview(PurchaseSelectedItemView(viewModel: $0))
        }
    }
}
