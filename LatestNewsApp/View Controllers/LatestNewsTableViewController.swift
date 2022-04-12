//
//  ViewController.swift
//  LatestNewsApp
//
//  Created by Герман Ставицкий on 08.04.2022.
//

import UIKit

class LatestNewsTableViewController: UITableViewController {
    
    private var news: [News] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 110
        fetchNewsPage()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
              let cell = tableView.dequeueReusableCell(
                withIdentifier: "newsCell",
                for: indexPath
               ) as? NewsCell
        else {
            return UITableViewCell()
            
        }
        
        let news = news[indexPath.row]
        cell.configure(with: news)
          
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = news[indexPath.row]
        performSegue(withIdentifier: "showNews", sender: news)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedNewsVC = segue.destination as? SelectedNewsViewController else { return }
        selectedNewsVC.news = sender as? News
    }
}

extension LatestNewsTableViewController {
    func fetchNewsPage() {
        let activityIndicator = showSpinner(in: tableView)
        
        guard let url = URL(string: "https://inshortsapi.vercel.app/news?category=science") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let news = try JSONDecoder().decode(NewsPage.self, from: data)
                self.news = news.data ?? []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    activityIndicator.stopAnimating()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
}

