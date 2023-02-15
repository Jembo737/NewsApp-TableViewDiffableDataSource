//
//  NewsTableViewCellModel.swift
//  NewsApp-TableViewDiffableDataSource
//
//  Created by Dzhemal on 13.02.2023.
//

import Foundation

class NewsTableViewCellViewModel: HashableClass {
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


open class HashableClass {
    public init() {}
}

// MARK: - <Hashable>

extension HashableClass: Hashable {

    public func hash(into hasher: inout Hasher) {
         hasher.combine(ObjectIdentifier(self))
    }
}

// MARK: - <Equatable>

extension HashableClass: Equatable {

    public static func ==(lhs: HashableClass, rhs: HashableClass) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}
