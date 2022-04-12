//
//  SelectedNewsViewController.swift
//  LatestNewsApp
//
//  Created by Герман Ставицкий on 08.04.2022.
//

import UIKit

class SelectedNewsViewController: UIViewController {
    
    @IBOutlet var newsImage: UIImageView!
    @IBOutlet var newsTitle: UILabel!
    @IBOutlet var newsDescription: UILabel!
    @IBOutlet var newsAuthor: UILabel!
    
    var news: News!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNewsDetails()
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let newsWebVC = segue.destination as? NewsWebViewController else { return }
        guard let someUrl = news.readMoreUrl else { return }
        newsWebVC.newsUrl = someUrl
    }

    @IBAction func readMore() {
        performSegue(withIdentifier: "showWeb", sender: nil)
    }
}

extension SelectedNewsViewController {
    func showNewsDetails() {
        newsTitle.text = news.title
        newsDescription.text = news.content
        newsAuthor.text = news.author
        
        guard let url = URL(string: news.imageUrl ?? "") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }

            DispatchQueue.main.async {
                self.newsImage.image = UIImage(data: data)
                self.newsImage.layer.cornerRadius = 15
            }
        }.resume()
    }
}

