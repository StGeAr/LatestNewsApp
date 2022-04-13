//
//  Category.swift
//  LatestNewsApp
//
//  Created by Герман Ставицкий on 13.04.2022.
//


struct DataManager {
    static let shared = DataManager()
    
    let category = Category.allCases
   
    private init() {}
    
    enum Category: String, CaseIterable {
        case all = "All"
        case business = "Business"
        case sports = "Sport"
        case world = "World"
        case politics = "Politics"
        case technology = "Technology"
        case startup = "Start up"
        case entertainment = "Entertainment"
        case miscellaneous = "Miscellaneous"
        case science = "Science"
        case automobile = "Automobile"
    }
}




