//
//  Quote.swift
//  Quo
//
//  Created by Federico Trimboli on 14/03/2018.
//

import Foundation

struct Quote {
    var id: Int?
    var message: String
    var author: String?
    var creationDate: Date
    
    init(id: Int? = nil, message: String, author: String? = nil, creationDate: Date = Date()) {
        self.id = id
        self.message = message
        self.author = author
        self.creationDate = creationDate
    }
}
