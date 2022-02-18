//
//  BusCell.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 15.02.2022.
//

import UIKit

class BusCell: UITableViewCell {

    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var fromToLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var avaiableLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(model: Bus){
        self.fromToLabel.text = "\(model.from) -\n\(model.to)"
        let hour = (model.time.hour < 10) ? "0\(model.time.hour)" : "\(model.time.hour)"
        let minute = (model.time.minute < 10) ? "0\(model.time.minute)" : "\(model.time.minute)"
        self.timeLabel.text = "\(hour):\(minute)"
        self.avaiableLabel.text = (model.seats.count == 45) ? "DOLDU" : "\(45 - model.seats.count) KALDI"
        self.avaiableLabel.textColor = (model.seats.count == 45) ? .systemRed : .black
        self.avaiableLabel.font = (model.seats.count == 45) ? .boldSystemFont(ofSize: 13) : .systemFont(ofSize: 13)
        self.feeLabel.text = "\(model.fee) TL"
        self.feeLabel.layer.cornerRadius = 10
        self.feeLabel.layer.masksToBounds = true
        self.feeLabel.backgroundColor = (model.seats.count == 45) ? .systemRed : .systemGreen
    }
}
