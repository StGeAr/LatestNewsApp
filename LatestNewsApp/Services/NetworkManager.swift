//
//  NeworkManager.swift
//  LatestNewsApp
//
//  Created by Герман Ставицкий on 12.04.2022.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
   
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: String?, with completion: @escaping(NewsPage) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let NewsPage = try JSONDecoder().decode(NewsPage.self, from: data)
                DispatchQueue.main.async {
                    completion(NewsPage)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func fetchImage(from url: String?, with completion: @escaping(Data) -> Void) {
        guard let stringURL = url else { return }
        guard let imageURL = URL(string: stringURL) else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
    
    func fetchDataWithAlamofire(_ url: String, completion: @escaping(Result<NewsPage, NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let newsPage = NewsPage.getNewsPage(from: value) else { return }
                    completion(.success(newsPage))
                case .failure(let error):
                    print(error)
                    completion(.failure(.decodingError))
                }
            }
    }
    
//    func fetchDataWithAlamofire(_ url: String, completion: @escaping(Result<News, NetworkError>) -> Void) {
//        AF.request(url)
//            .validate()
//            .responseJSON { dataResponse  in
//                switch dataResponse.result {
//                case .success(let value):
//                    guard let newsPage = NewsPage.getNewsPage(from: value) else { return }
//                    completion(.success(newsPage))
//                case .failure(_):
//                    <#code#>
//                }
//            }
//    }
}

