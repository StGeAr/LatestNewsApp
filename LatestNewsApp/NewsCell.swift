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
    @IBOutlet var newsImage: UIImageView!
    
    
    func configure(with news: News) {
        
        newsTitle.text = news.title
        publicationDate.text = news.date
        
        guard let url = URL(string: news.imageUrl  ?? "") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }

            DispatchQueue.main.async {
                self.newsImage.image = UIImage(data: data)
            }
        }.resume()
    }
}
