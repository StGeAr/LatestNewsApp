//
//  NewsCell.swift
//  LatestNewsApp
//
//  Created by Герман Ставицкий on 08.04.2022.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet var newsTitle: UILabel!
    @IBOutlet var publicationDate: UILabel!
    @IBOutlet var newsImage: UIImageView! {
        didSet {
            newsImage.layer.cornerRadius = newsImage.frame.height / 2
        }
    }
    
    
    func configure(with news: News) {
        newsTitle.text = news.title
        publicationDate.text = news.date
        
        NetworkManager.shared.fetchImage(from: news.imageUrl) { imageData in
            self.newsImage.image = UIImage(data: imageData)
        }
    }
}
