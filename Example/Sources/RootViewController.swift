//
//  RootViewController.swift
//  Example
//
//  Created by Tomoya Hayakawa on 2019/02/10.
//  Copyright © 2019年 simorgh3196. All rights reserved.
//

import UIKit
import WebKit
import WebViewWarmupper

class RootViewController: UIViewController {

    let warmupper = WebViewWarmupper(maxSize: 2)
    let sharedWKWebView = WKWebView()

    lazy var showWarmupedWKWebViewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Warmupped WKWebView", for: .normal)
        button.addTarget(self, action: #selector(didTapShowWarmuppedWKWebViewButton), for: .touchUpInside)
        return button
    }()
    lazy var showSharedInstanceWKWebViewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Shared WKWebView", for: .normal)
        button.addTarget(self, action: #selector(didTapSharedWKWebViewButton), for: .touchUpInside)
        return button
    }()
    lazy var showSimpleWKWebViewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Simple WKWebView", for: .normal)
        button.addTarget(self, action: #selector(didTapSimpleWKWebViewButton), for: .touchUpInside)
        return button
    }()
    lazy var showSimpleUIWebViewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Simple UIWebView", for: .normal)
        button.addTarget(self, action: #selector(didTapSimpleUIWebViewButton), for: .touchUpInside)
        return button
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupLayout()
        warmupper.warmupUpToSize()
        _ = sharedWKWebView
    }

    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [
            showWarmupedWKWebViewButton,
            showSharedInstanceWKWebViewButton,
            showSimpleWKWebViewButton,
            showSimpleUIWebViewButton
            ])
        stackView.spacing = 12
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
            ])
    }

    @objc private func didTapShowWarmuppedWKWebViewButton() {
        let viewController = WarmupedWKWebViewController(warmupper: warmupper)
        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc private func didTapSharedWKWebViewButton() {
        let viewController = SharedWKWebViewController(sharedWKWebView: sharedWKWebView)
        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc private func didTapSimpleWKWebViewButton() {
        let viewController = SimpleWKWebViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc private func didTapSimpleUIWebViewButton() {
        let viewController = SimpleUIWebViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
