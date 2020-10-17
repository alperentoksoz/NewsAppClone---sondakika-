//
//  Article.swift
//  NewsAppMVVMv2
//
//  Created by Alperen Toksöz on 15.06.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

struct Articles : Decodable {
    let all : [Article]?
    
    enum CodingKeys: String, CodingKey {
        case all = "articles"
    }

}

struct Article : Decodable {
    let title : String?
    let urlToImage : String?
    let content: String?
    let date: String
    let newsUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case urlToImage = "urlToImage"
        case content
        case date = "publishedAt"
        case newsUrl =  "url"
    }

}
