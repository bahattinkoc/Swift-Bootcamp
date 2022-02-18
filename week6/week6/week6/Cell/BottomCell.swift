//
//  BottomCell.swift
//  week6
//
//  Created by Bahattin Koç on 11.02.2022.
//

import UIKit

class BottomCell: UICollectionViewCell, EDevletCellProtocol {
    static var reuseIdentifier: String = "BottomCell"
    
    let title = UILabel()
    let subtitle = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        title.font = .preferredFont(forTextStyle: .headline)
        title.textColor = .label
        title.numberOfLines = 0
        
        subtitle.font = .preferredFont(forTextStyle: .subheadline)
        subtitle.textColor = .secondaryLabel
        subtitle.numberOfLines = 0
        
        let innerStackView = UIStackView(arrangedSubviews: [title, subtitle])
        innerStackView.axis = .vertical
        
        let outerStackView = UIStackView(arrangedSubviews: [imageView, innerStackView])
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        outerStackView.spacing = 10
        
        contentView.addSubview(outerStackView)
        
        NSLayoutConstraint.activate([
            outerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            outerStackView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with edevlet: EDevlet?) {
        title.text = edevlet?.name
        subtitle.text = edevlet?.subheading
        imageView.image = UIImage(named: edevlet?.image ?? "e-devlet_logo")
    }
}
