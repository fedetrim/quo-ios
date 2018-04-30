//
//  ChronologicalQuotesViewController.swift
//  Quo
//
//  Created by Federico Trimboli on 14/03/2018.
//

import UIKit

final class ChronologicalQuotesViewController: UIViewController {
    
    @IBOutlet private var tableViewController: QuotesTableViewController!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshQuotes()
    }
    
    @objc private func tableRefreshDidTrigger() {
        refreshQuotes()
    }
    
    private func refreshQuotes() {
        QuotesService.fetchQuotes { [weak self] (quotes, error) in
            self?.activityIndicatorView.isHidden = true
            
            guard let quotes = quotes else { return }
            self?.tableViewController.quotes = quotes
            self?.tableViewController.refreshControl?.endRefreshing()
        }
    }
    
}

// MARK: - Storyboard
extension ChronologicalQuotesViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? QuotesTableViewController {
            tableViewController = vc
            
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(tableRefreshDidTrigger), for: .valueChanged)
            tableViewController.refreshControl = refreshControl
        }
    }
    
}
