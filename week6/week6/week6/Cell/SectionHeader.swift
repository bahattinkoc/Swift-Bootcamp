//
//  SectionHeader.swift
//  week6
//
//  Created by Bahattin Koç on 12.02.2022.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeader"
    
    let title = UILabel()
    let seperator = UIView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        seperator.backgroundColor = .lightGray
        seperator.translatesAutoresizingMaskIntoConstraints = false // NSLayoutConstraint için gerekli
        
        title.textColor = .label
        title.font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: 20, weight: .bold))
        
        let stackView = UIStackView(arrangedSubviews: [seperator, title])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            seperator.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor)
            // Bottom için kontrol et
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
