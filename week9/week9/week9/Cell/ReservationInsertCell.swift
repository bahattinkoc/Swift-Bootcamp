//
//  ReservationInsertCell.swift
//  week9
//
//  Created by Bahattin Koç on 5.03.2022.
//

import UIKit

class ReservationInsertCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView! {
        didSet{
            cardView.layer.borderWidth = 1
            cardView.layer.borderColor = UIColor(red: 0.09, green: 0.81, blue: 0.77, alpha: 1).cgColor
            cardView.layer.cornerRadius = 5
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
