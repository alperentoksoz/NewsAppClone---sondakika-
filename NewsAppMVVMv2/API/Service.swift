//
//  Service.swift
//  NewsAppMVVMv2
//
//  Created by Alperen Toksöz on 15.06.2020.
//  Copyright © 2020 Alperen Toksöz. All rights reserved.
//

import Foundation

private let url = URL(string: "HERE NEWS API KEY")

class Service {
        
        static func getArticles(completion: @escaping (ArticleList?) -> ()) {
    
            URLSession.shared.dataTask(with: url!) { data, response, error in
                
                if let error = error {
                    print(error.localizedDescription)
                }
                else if let data = data {
                    let json = try? JSONDecoder().decode(ArticleList.self, from: data)
                    if let json = json {
            
                        completion(json)
                    }
                }
            }.resume()
        }
}
