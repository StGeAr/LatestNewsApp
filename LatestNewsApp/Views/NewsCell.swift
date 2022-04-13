//
//  NewsCell.swift
//  LatestNewsApp
//
//  Created by Герман Ставицкий on 08.04.2022.
//

import UIKit

class NewsCell: UITableViewCell {
    
    // MARK:- IBOutlets
    @IBOutlet var newsTitle: UILabel!
    @IBOutlet var publicationDate: UILabel!
    @IBOutlet var newsImage: UIImageView! {
        didSet {
            newsImage.layer.cornerRadius = newsImage.frame.height / 2
        }
    }
    
    // MARK: - Public methods
    func configure(with news: News) {
        newsTitle.text = news.title 
        publicationDate.text = news.date
        
//        NetworkManager.shared.fetchImage(from: news.imageUrl) { imageData in
//            self.newsImage.image = UIImage(data: imageData)
//        }
        
        NetworkManager.shared.fetchImageWithAlamofire(news.imageUrl ?? "") { result in
            switch result {
            case .success(let imageData):
                self.newsImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
