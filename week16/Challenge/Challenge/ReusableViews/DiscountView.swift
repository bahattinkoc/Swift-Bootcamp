//
//  DiscountView.swift
//  Challenge
//
//  Created by Bahattin Koç on 16.04.2022.
//

import UIKit

class DiscountView: UIView {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var msgLabel: UILabel!
    
    private var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(model: Discount) {
        
    }
    
    @IBAction func deleteDiscountActionButton(_ sender: Any) {
        
    }
    
}
