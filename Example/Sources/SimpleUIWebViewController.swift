//
//  SimpleUIWebViewController.swift
//  Example
//
//  Created by Tomoya Hayakawa on 2019/02/10.
//  Copyright © 2019年 simorgh3196. All rights reserved.
//

import UIKit

class SimpleUIWebViewController: UIViewController {

    private static var loadTimeHistory = [TimeInterval]()

    private var loadStartTime: Date!

    override func viewDidLoad() {
        let webView = UIWebView()
        webView.delegate = self

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
        webView.loadRequest(request)
    }
}

extension SimpleUIWebViewController: UIWebViewDelegate {

    func webViewDidFinishLoad(_ webView: UIWebView) {
        let time = -loadStartTime.timeIntervalSinceNow
        SimpleUIWebViewController.loadTimeHistory.append(time)
        let historyCount = SimpleUIWebViewController.loadTimeHistory.count
        let average = SimpleUIWebViewController.loadTimeHistory.reduce(0, +) / Double(SimpleUIWebViewController.loadTimeHistory.count)
        print("Simple UIWebView - Loading Time: \(time), Average[\(historyCount)]: \(average)")
    }
}
