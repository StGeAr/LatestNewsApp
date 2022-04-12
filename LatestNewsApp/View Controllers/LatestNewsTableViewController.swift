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
        fetchData(from: "https://inshortsapi.vercel.app/news?category=science")
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
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemGray
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
    private func fetchData(from url: String?) {
        let activityIndicator = showSpinner(in: tableView)
        
        NetworkManager.shared.fetchData(from: url) { NewsPage in
            self.news = NewsPage.data ?? []
            self.tableView.reloadData()
            activityIndicator.stopAnimating()
        }
    }
}

