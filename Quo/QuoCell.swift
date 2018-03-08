//
//  QuoCell.swift
//  Quo
//
//  Created by Federico Trimboli on 07/03/2018.
//

import UIKit

final class QuoCell: UITableViewCell {
    
    @IBOutlet weak var cardBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardBackgroundView.layer.cornerRadius = 12
    }
    
}
