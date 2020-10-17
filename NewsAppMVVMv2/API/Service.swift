//
//  Service.swift
//  NewsAppMVVMv2
//
//  Created by Alperen Toksöz on 15.06.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import Foundation
import Alamofire

private let url = "http://newsapi.org/v2/top-headlines?category=technology&apiKey="+API_KEY

class Service {
    
    static var shared = Service()
    
    func getArticles(completion: @escaping (Articles) -> ()) {
        
        let request = AF.request(url)
        .validate()
            .responseDecodable(of: Articles.self) { (response) in
                guard let articles = response.value else { return }
                completion(articles)
        }
    }
}
