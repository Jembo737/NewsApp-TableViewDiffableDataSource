//
//  NewsTableViewCellModel.swift
//  NewsApp-TableViewDiffableDataSource
//
//  Created by Dzhemal on 13.02.2023.
//

import Foundation

class NewsTableViewCellViewModel {
    let title: String
    let author: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String, author: String, imageURL: URL?) {
        self.title = title
        self.author = author
        self.imageURL = imageURL
    }
}
