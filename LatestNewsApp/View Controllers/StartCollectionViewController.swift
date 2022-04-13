//
//  StartCollectionViewController.swift
//  LatestNewsApp
//
//  Created by Герман Ставицкий on 13.04.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class StartCollectionViewController: UICollectionViewController {
    
    let category = DataManager.shared.category
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        category.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "cell",
                for: indexPath
            ) as? CategoryCell
        else {
            return UICollectionViewCell()
        }
        cell.categoryLabel.text = category[indexPath.item].rawValue
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = category[indexPath.item]
        switch category {
        case .all: performSegue(withIdentifier: "showCategoryNews", sender: "all")
        case .business: performSegue(withIdentifier: "showCategoryNews", sender: "business")
        case .sports: performSegue(withIdentifier: "showCategoryNews", sender: "sports")
        case .world: performSegue(withIdentifier: "showCategoryNews", sender: "world")
        case .politics: performSegue(withIdentifier: "showCategoryNews", sender: "politics")
        case .technology: performSegue(withIdentifier: "showCategoryNews", sender: "technology")
        case .startup: performSegue(withIdentifier: "showCategoryNews", sender: "startup")
        case .entertainment: performSegue(withIdentifier: "showCategoryNews", sender: "entertainment")
        case .miscellaneous: performSegue(withIdentifier: "showCategoryNews", sender: "miscellaneous")
        case .science: performSegue(withIdentifier: "showCategoryNews", sender: "science")
        case .automobile: performSegue(withIdentifier: "showCategoryNews", sender: "automobile")
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let latestNewsVC = segue.destination as? LatestNewsTableViewController else { return }
        latestNewsVC.categoryUrl = "https://inshortsapi.vercel.app/news?category=\(sender ?? "all")"
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension StartCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 70, height: 60)
    }
}
