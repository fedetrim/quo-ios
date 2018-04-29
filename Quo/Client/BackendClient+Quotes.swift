//
//  BackendClient+Quotes.swift
//  Quo
//
//  Created by Federico Trimboli on 28/04/2018.
//

import Foundation

extension BackendClient {
    
    static func fetchQuotes(completion: @escaping ([QuoteResponse]?, Swift.Error?) -> Void) {
        guard let url = url(withPath: "quotes") else {
            completion(nil, Error.couldNotFormURL)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = defaultHeaders
        
        execute(request) { (response, error) in
            completion(response, error)
        }
    }
    
}

// MARK: - Response
struct QuoteResponse: Decodable {
    var id: Int
    var message: String
    var author: String?
    var creationDate: Date
}
