//
//  File.swift
//  LatestNewsApp
//
//  Created by Герман Ставицкий on 08.04.2022.
//

struct News: Decodable {
    let author: String?
    let content: String?
    let date: String?
    let imageUrl: String?
    let readMoreUrl: String?
    let title: String?
}

struct NewsPage: Decodable {
    let category: String?
    let data: [News]?
}

