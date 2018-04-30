//
//  QuoCell.swift
//  Quo
//
//  Created by Federico Trimboli on 07/03/2018.
//

import UIKit

final class QuoteCell: UITableViewCell {
    
    @IBOutlet weak var cardBackgroundView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var viewData = ViewData(message: "", author: "", dateText: "") {
        didSet {
            updateLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardBackgroundView.layer.cornerRadius = 12
    }
    
    private func updateLayout() {
        messageLabel.text = viewData.message
        authorLabel.text = viewData.author
        dateLabel.text = viewData.dateText
    }
    
}

extension QuoteCell {
    
    struct ViewData {
        var message: String
        var author: String
        var dateText: String
    }
    
}

extension QuoteCell.ViewData {
    
    init(quote: Quote) {
        message = "“" + quote.message + "“"
        author = quote.author ?? "Anónimo"
        dateText = quote.creationDate.timeAgo
    }
    
}
