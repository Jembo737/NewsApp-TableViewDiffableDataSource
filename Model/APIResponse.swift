//
//  APIResponse.swift
//  NewsApp-TableViewDiffableDataSource
//
//  Created by Dzhemal on 13.02.2023.
//

import Foundation

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let author: String?
    let url: String?
    let urlToImage: String?
}

struct Source: Codable {
    let name: String
}
