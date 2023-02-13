//
//  DataCaller.swift
//  NewsApp-TableViewDiffableDataSource
//
//  Created by Dzhemal on 13.02.2023.
//

import Foundation

// Singleton Class
final class DataCaller {
    static let shared = DataCaller()
    
    struct Constant {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=48c7777c851d4d27a317465dce23eeb0")
    }
    
    private init() {}
    
    public func getTopStories(comletion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constant.topHeadlinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                comletion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Articles \(result.articles.count)")
                    comletion(.success(result.articles))
                }
                catch {
                    comletion(.failure(error))
                }
            }
        }
        task.resume()
    }
}


