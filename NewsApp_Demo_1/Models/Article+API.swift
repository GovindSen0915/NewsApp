//
//  Article+API.swift
//  NewsApp_Demo_1
//
//  Created by Nickelfox on 19/04/23.
//

import Foundation
import FoxAPIKit
import ReactiveSwift

extension Article {
    
//    public static func fetch(params: [String:Any]) -> SignalProducer<[Article], ModelError>{
//        return SignalProducer.init { observer, lifetime in
//            let router = NewsRouter.fetchNews(params)
//            NewsAPIClient.shared.request(router) { (result :
//                APIResult<ListResponse<Article>>) in
//                switch result {
//                case .success(let value):
//                    let articles: [Article] = value.list
//                    print(articles, "Articles")
//                    observer.send(value: articles)
//                    observer.sendCompleted()
//                case .failure(let error):
//                    observer.send(error: ModelError.custom(message: error.message))
//                }
//            }
//        }
//    }
    
    public static func fetch() -> SignalProducer<[Article], ModelError>{
        return SignalProducer.init { observer, lifetime in
            let router = NewsRouter.fetchNews
            NewsAPIClient.shared.request(router) { (result :
                APIResult<ListResponse<Article>>) in
                switch result {
                case .success(let value):
                    let articles: [Article] = value.list
                    print(articles, "Articles")
                    observer.send(value: articles)
                    observer.sendCompleted()
                case .failure(let error):
                    observer.send(error: ModelError.custom(message: error.message))
                }
            }
        }
    }
}

