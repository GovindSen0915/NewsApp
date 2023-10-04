//
//  NewsRouter.swift
//  NewsApp_Demo_1
//
//  Created by Nickelfox on 19/04/23.
//

import Foundation
import FoxAPIKit



public enum NewsRouter: BaseRouter {
//    case fetchNews(_ params: [String:Any])
    case fetchNews
    public var method: HTTPMethod {
        switch self {
        case .fetchNews:
            return .get
        }
    }
    
    public var path: String {
        switch self {
        case .fetchNews:
            return ""
        }
    }
    
    public var params: [String : Any] {
        switch self {
//        case .fetchNews(let params):
//            return params
        case .fetchNews:
            var params = [
                "apiKey": "e7855adfcfbb4dd69e3fd27172d1aa4e",
                "q": "apple",
    //            "from": "2023-07-30",
    //            "to": "2023-07-30",
                "sortBy": "popularity"
            ]
            return params
        }
    }
    
    public var keypathToMap: String? {
        switch self {
        default:
            return "articles"
        }
    }
}
