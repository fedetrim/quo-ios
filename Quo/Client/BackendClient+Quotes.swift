//
//  BackendClient+Quotes.swift
//  Quo
//
//  Created by Federico Trimboli on 28/04/2018.
//

import Foundation

// MARK: - Fetch Quotes

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

struct QuoteResponse: Decodable {
    var id: Int
    var message: String
    var author: String?
    var creationDate: Date
}

// MARK: - Create Quote

extension BackendClient {
    
    static func createQuote(withMessage message: String, author: String?, completion: @escaping (QuoteResponse?, Swift.Error?) -> Void) {
        guard let url = url(withPath: "quotes") else {
            completion(nil, Error.couldNotFormURL)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = defaultHeaders
        
        do {
            let body = CreateQuoteBody(message: message, author: author)
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(nil, error)
        }
        
        execute(request) { (response, error) in
            completion(response, error)
        }
    }
    
}

struct CreateQuoteBody: Encodable {
    var message: String
    var author: String?
}
