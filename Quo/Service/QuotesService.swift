//
//  QuotesCache.swift
//  Quo
//
//  Created by Federico Trimboli on 19/03/2018.
//

import Foundation

struct QuotesService {
    
    static func createQuote(withMessage message: String, author: String?) {
        QuotesCache.quotes.insert(Quote(message: message, author: author), at: 0)
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

    static fileprivate(set) var quotes: [Quote] = [
        Quote(message: "Be a yardstick of quality. Some people aren't used to an environment where excellence is expected.", author: "Steve Jobs", creationDate: Date()),
        Quote(message: "If you push me towards something that you think is a weakness, then I will turn that perceived weakness into a strength.", author: "Michael Jordan", creationDate: Date()),
        Quote(message: "Tengo razón.", author: "Federico Trimboli", creationDate: Date()),
        Quote(message: "That is the most expensive phone in the world and it doesn't appeal to business customers because it doesn't have a keyboard, which makes it not a very good email machine.", author: "", creationDate: Date()),
        Quote(message: "Having small touches of colour makes it more colourful than having the whole thing in colour.", author: "Dieter Rams", creationDate: Date()),
        Quote(message: "Aluminium.", author: "Jony Ive", creationDate: Date())
    ]
    
    private init() { }
    
}
