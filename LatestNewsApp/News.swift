//
//  File.swift
//  LatestNewsApp
//
//  Created by Герман Ставицкий on 08.04.2022.
//

struct News: Decodable {
    let author: String?
    let category: [String]?
    let description: String?
    let image: String?
    let published: String?
    let title: String?
    let url: String?
}

struct NewsPage: Decodable {
    let news: [News]?
    let page: Int?
    let status: String?
}
