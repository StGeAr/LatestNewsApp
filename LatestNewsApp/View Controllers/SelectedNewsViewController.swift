//
//  SelectedNewsViewController.swift
//  LatestNewsApp
//
//  Created by Герман Ставицкий on 08.04.2022.
//

import UIKit

class SelectedNewsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var newsTitle: UILabel!
    @IBOutlet var newsDescription: UILabel!
    @IBOutlet var newsAuthor: UILabel!
    @IBOutlet var newsImage: UIImageView! {
        didSet {
            newsImage.layer.cornerRadius = 15
        }
    }
    
    // MARK: - Public properties
    var news: News!
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        showNewsDetails()
    }
        
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let newsWebVC = segue.destination as? NewsWebViewController else { return }
        newsWebVC.newsUrl = news.readMoreUrl
    }
    
    // MARK: - Private methods
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemGray
        activityIndicator.startAnimating()
//        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
    private func showNewsDetails() {
        let activityIndicator = showSpinner(in: newsImage)
        
        newsTitle.text = news.title
        newsDescription.text = news.content
        newsAuthor.text = news.author
        
        NetworkManager.shared.fetchImage(from: news.imageUrl) { imageData in
            self.newsImage.image = UIImage(data: imageData)
            activityIndicator.stopAnimating()
        }
    }
}
