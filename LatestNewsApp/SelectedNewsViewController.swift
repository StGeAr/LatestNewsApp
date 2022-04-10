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
    
    var news: News!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNewsDetails()
    }
        
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

    @IBAction func readMore() {
        performSegue(withIdentifier: "showWeb", sender: nil)
    }
}

extension SelectedNewsViewController {
    func showNewsDetails() {
        newsTitle.text = news.title
        newsDescription.text = news.content
        
        guard let url = URL(string: news.imageUrl  ?? "") else { return }
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

