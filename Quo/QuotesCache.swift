//
//  QuotesCache.swift
//  Quo
//
//  Created by Federico Trimboli on 19/03/2018.
//

import Foundation

struct QuotesCache {

    static private(set) var quotes: [Quote] = [
        Quote(id: "1", message: "Be a yardstick of quality. Some people aren't used to an environment where excellence is expected.", author: "Steve Jobs", creationDate: Date()),
        Quote(id: "2", message: "If you push me towards something that you think is a weakness, then I will turn that perceived weakness into a strength.", author: "Michael Jordan", creationDate: Date()),
        Quote(id: "3", message: "Tengo razón.", author: "Federico Trimboli", creationDate: Date()),
        Quote(id: "4", message: "That is the most expensive phone in the world and it doesn't appeal to business customers because it doesn't have a keyboard, which makes it not a very good email machine.", author: "", creationDate: Date()),
        Quote(id: "5", message: "Having small touches of colour makes it more colourful than having the whole thing in colour.", author: "Dieter Rams", creationDate: Date()),
        Quote(id: "6", message: "Aluminium.", author: "Jony Ive", creationDate: Date())
    ]
    
    private init() { }
    
}
