//
//  CityCell.swift
//  week_4
//
//  Created by Bahattin Koç on 28.01.2022.
//

import UIKit

class CityCell: UITableViewCell {
    @IBOutlet weak var famousImg: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var famousName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("awake")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(model: CityModel){
        self.famousImg.image = UIImage(named: model.famousImg)
        self.cityName.text = model.name
        self.famousName.text = model.famous
    }
}
