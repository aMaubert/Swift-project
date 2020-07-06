//
//  AuthentService.swift
//  project
//
//  Created by allan on 06/07/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import SwiftUI

struct AuthentService {
    
    public static func baseUri() -> String {
        if let baseUri = StoreService.get(key: "API_BASE_URL") {
            return "\(baseUri)/account"
        }
        return ""
    }
    
    public static func makeUrlRequest(url: URL, httpMethod: String, bearerToken: String? ) -> URLRequest {
            var request = URLRequest(url: url)
            request.httpMethod = httpMethod
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            if let token = bearerToken {
                request.addValue(token, forHTTPHeaderField: "Authorization")
            }
            request.timeoutInterval = 2000000.0
            return request
    }
    
    public static func encodeAccountLogin(_ accountLogin: AccountLogin) -> Data? {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(accountLogin)
        return data
    }
    
    public static func decodeToken(_ data: Data) -> Token? {
        let decoder = JSONDecoder()
        let token = try? decoder.decode(Token.self, from: data)
        return token
    }
    
    
    
}
