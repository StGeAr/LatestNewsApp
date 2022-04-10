//
//  NewsViewController.swift
//  LatestNewsApp
//
//  Created by Герман Ставицкий on 08.04.2022.
//

import UIKit
import WebKit

class NewsWebViewController: UIViewController {

    var newsUrl: String!
    
    private var webView: WKWebView!
    
    override func viewDidLoad() {
        guard let url = URL(string: newsUrl) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension NewsWebViewController: WKUIDelegate {
    override func loadView() {
        let webConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfig)
        webView.uiDelegate = self
        view = webView
    }
}
