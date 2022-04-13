//
//  File.swift
//  LatestNewsApp
//
//  Created by Герман Ставицкий on 08.04.2022.
//

struct NewsPage: Codable {
    let data: [News]?
    
    init(newsPageData: [String: Any]) {
        data = newsPageData["data"] as? [News]
    }
}

struct News: Codable {
    let author: String?
    let content: String?
    let date: String?
    let imageUrl: String?
    let readMoreUrl: String?
    let title: String?
    
    init(newsData: [String: Any]) {
        author = newsData["author"] as? String
        content = newsData["content"] as? String
        date = newsData["date"] as? String
        imageUrl = newsData["imageUrl"] as? String
        readMoreUrl = newsData["readMoreUrl"] as? String
        title = newsData["title"] as? String
    }
    
    static func getNews(from value: Any) -> [News] {
        guard let data = value as? [String:Any] else { return [] }
        guard let news = data["data"] as? [[String:Any]] else { return [] }
        return news.compactMap { News(newsData: $0) }
    }
}

