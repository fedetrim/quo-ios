//
//  FirstViewController.swift
//  Quo
//
//  Created by Federico Trimboli on 04/03/2018.
//

import UIKit

class QuotesTableViewController: UITableViewController {
    
    var quotes: [Quote] = [] {
        didSet {
            let quotesAdded = quotes.filter { oldValue.contains($0) == false }
            let newIndexPaths = quotesAdded.enumerated().map { IndexPath(row: $0.offset, section: 0) }
            tableView.insertRows(at: newIndexPaths, with: .automatic)
        }
    }
    
}

// MARK - UITableViewDataSource
extension QuotesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! QuoteCell
        cell.viewData = .init(quote: quotes[indexPath.row])
        return cell
    }

}

