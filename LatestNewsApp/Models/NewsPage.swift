//
//  File.swift
//  LatestNewsApp
//
//  Created by Герман Ставицкий on 08.04.2022.
//

struct NewsPage: Codable {
    let category: String?
    let data: [News]?
    
    init(newsPageData: [String: Any]) {
        category = newsPageData["category"] as? String
        data = newsPageData["data"] as? [News]
    }
    
    static func getNewsPage(from value: Any) -> NewsPage? {
        guard let newsPageData = value as? [String: Any] else { return nil }
        let newsPage = NewsPage(newsPageData: newsPageData)
        return newsPage
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
    
//    static func transformToNews(data: Any) -> [News] {
//        guard let data = data as? [[String:Any]] else { return [] }
//        return data.compactMap { News(newsData: $0) }
//    }
}

