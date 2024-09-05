//
//  BookSearchResponse.swift
//  BookReview
//
//  Created by 왕정빈 on 9/4/24.
//

import Foundation

struct BookSearchResponse: Codable {
    var items: [Book] = []
}

struct Book: Codable {
    let title: String
    private let image: String?
    
    var imageURL: URL? { URL(string: image ?? "") }
}
