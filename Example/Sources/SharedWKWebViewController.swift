//
//  SharedWKWebViewController.swift
//  Example
//
//  Created by Tomoya Hayakawa on 2019/02/10.
//  Copyright © 2019年 simorgh3196. All rights reserved.
//

import UIKit
import WebKit

class SharedWKWebViewController: UIViewController {

    private static var loadTimeHistory = [TimeInterval]()

    private let webView: WKWebView

    private var loadStartTime: Date!

    init(sharedWKWebView: WKWebView) {
        self.webView = sharedWKWebView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self

        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            ])

        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "Sample", ofType: "html")!)
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)

        loadStartTime = Date()
        webView.load(request)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        webView.navigationDelegate = nil
        webView.removeFromSuperview()
        webView.stopLoading()
        webView.evaluateJavaScript("document.body.innerHTML = \"\"")
    }
}

extension SharedWKWebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let time = -loadStartTime.timeIntervalSinceNow
        SharedWKWebViewController.loadTimeHistory.append(time)
        let historyCount = SharedWKWebViewController.loadTimeHistory.count
        let average = SharedWKWebViewController.loadTimeHistory.reduce(0, +) / Double(SharedWKWebViewController.loadTimeHistory.count)
        print("Shared WKWebView - Loading Time: \(time), Average[\(historyCount)]: \(average)")
    }
}
