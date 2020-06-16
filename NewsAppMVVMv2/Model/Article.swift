//
//  Article.swift
//  NewsAppMVVMv2
//
//  Created by Alperen Toksöz on 15.06.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import Foundation


struct ArticleList : Codable {

    let articles : [Article]?


}
struct Article : Codable {

    let descriptionField : String?
    let title : String?
    let urlToImage : String?


}
