//
//  WarmupedWKWebViewController.swift
//  Example
//
//  Created by Tomoya Hayakawa on 2019/02/10.
//  Copyright © 2019年 simorgh3196. All rights reserved.
//

import UIKit
import WebKit
import WebViewWarmuper

class WarmupedWKWebViewController: UIViewController {

    private let warmuper: WebViewWarmuper

    private var loadStartTime: Date!

    init(warmuper: WebViewWarmuper) {
        self.warmuper = warmuper
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        guard let webView = warmuper.getView() else {
            print("warmuped views empty")
            return
        }
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
}

extension WarmupedWKWebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let time = -loadStartTime.timeIntervalSinceNow
        print("Warmuped WKWebView - Loading Time: \(time)")
    }
}
