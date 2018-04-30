//
//  QuotesCache.swift
//  Quo
//
//  Created by Federico Trimboli on 19/03/2018.
//

import Foundation

struct QuotesService {
    
    static func createQuote(withMessage message: String, author: String?, completion: @escaping (Quote?, Swift.Error?) -> Void) {
        BackendClient.createQuote(withMessage: message, author: author) { (quoteResponse, error) in
            guard let quoteResponse = quoteResponse else {
                DispatchQueue.main.async { completion(nil, error ?? Error.unknown) }
                return
            }
            
            let quote = Quote(id: quoteResponse.id,
                              message: quoteResponse.message,
                              author: quoteResponse.author,
                              creationDate: quoteResponse.creationDate)
            
            QuotesCache.quotes.insert(quote, at: 0)
            DispatchQueue.main.async { completion(quote, nil) }
        }
    }
    
    static func fetchQuotes(completion: @escaping ([Quote]?, Swift.Error?) -> Void) {
        BackendClient.fetchQuotes { (quotesResponses, error) in
            guard let quotesResponses = quotesResponses else {
                DispatchQueue.main.async { completion(nil, error ?? Error.unknown) }
                return
            }
            
            let quotes = quotesResponses.map { (quoteResponse) -> Quote in
                return Quote(id: quoteResponse.id,
                             message: quoteResponse.message,
                             author: quoteResponse.author,
                             creationDate: quoteResponse.creationDate)
            }
            
            QuotesCache.quotes = quotes
            DispatchQueue.main.async { completion(quotes, nil) }
        }
    }
    
    private init() { }
    
}

extension QuotesService {
    enum Error: Swift.Error {
        case unknown
    }
}

struct QuotesCache {

    static fileprivate(set) var quotes: [Quote] = []
    
    private init() { }
    
}
