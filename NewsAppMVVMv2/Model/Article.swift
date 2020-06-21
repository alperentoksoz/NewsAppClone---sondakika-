//
//  Article.swift
//  NewsAppMVVMv2
//
//  Created by Alperen Toksöz on 15.06.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import Foundation


struct ArticleList : Decodable {

    let articles : [Article]?


}
struct Article : Decodable {

    let descriptionField : String?
    let title : String?
    let urlToImage : String?
    let content: String?

}
