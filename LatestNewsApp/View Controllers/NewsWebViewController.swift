//
//  NewsViewController.swift
//  LatestNewsApp
//
//  Created by Герман Ставицкий on 08.04.2022.
//

import UIKit
import WebKit

class NewsWebViewController: UIViewController {

    // MARK: - Public properties
    var newsUrl: String!
    
    //MARK: - Private properties
    var webView: WKWebView!
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        let activityIndicator = showSpinner(in: webView)
        guard let webUrl = newsUrl else { return }
        guard
            let webUrlSring = webUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {
            return
        }
        guard let url = URL(string: webUrlSring) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Private methods
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemGray
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
}

// MARK: - WKUIDelegate
extension NewsWebViewController: WKUIDelegate {
    override func loadView() {
        let webConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfig)
        webView.uiDelegate = self
        view = webView
    }
}
