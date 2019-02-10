//
//  WarmupedWKWebViewController.swift
//  Example
//
//  Created by Tomoya Hayakawa on 2019/02/10.
//  Copyright © 2019年 simorgh3196. All rights reserved.
//

import UIKit
import WebKit
import WebViewWarmupper

class WarmupedWKWebViewController: UIViewController {

    private static var loadTimeHistory = [TimeInterval]()

    private let warmupper: WebViewWarmupper

    private var loadStartTime: Date!

    init(warmupper: WebViewWarmupper) {
        self.warmupper = warmupper
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        guard let webView = warmupper.getView() else {
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

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        warmupper.warmupUpToSize()
    }
}

extension WarmupedWKWebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let time = -loadStartTime.timeIntervalSinceNow
        WarmupedWKWebViewController.loadTimeHistory.append(time)
        let historyCount = WarmupedWKWebViewController.loadTimeHistory.count
        let average = WarmupedWKWebViewController.loadTimeHistory.reduce(0, +) / Double(WarmupedWKWebViewController.loadTimeHistory.count)
        print("Warmuped WKWebView - Loading Time: \(time), Average[\(historyCount)]: \(average)")
    }
}
