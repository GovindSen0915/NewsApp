//
//  NewsAPIClient.swift
//  NewsApp_Demo_1
//
//  Created by Nickelfox on 19/04/23.
//

import Foundation
import FoxAPIKit

public typealias APICompletion<T> = (APIResult<T>) -> Void

class NewsAPIClient: APIClient<AuthHeaders, ErrorResponse> {
    
    static let shared = NewsAPIClient()
    
    override init() {
        super.init()
        #if DEBUG
        enableLogs = true
        #else
        enableLogs = false
        #endif
    }
    
    override func authenticationHeaders(response: HTTPURLResponse) -> AuthHeaders? {
        return nil
    }
}

