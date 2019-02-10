//
//  WebViewWarmuper.swift
//  WebViewWarmuper
//
//  Created by Tomoya Hayakawa on 2019/02/10.
//  Copyright © 2019年 simorgh3196. All rights reserved.
//

import WebKit

open class WebViewWarmuper: ViewWarmuper<WKWebView> {

    public init(maxSize: UInt) {
        super.init(maxSize: maxSize) {
            return WKWebView()
        }
    }
}
