//
//  TopCell.swift
//  week6
//
//  Created by Bahattin Koç on 11.02.2022.
//

import UIKit

class TopCell: UICollectionViewCell, EDevletCellProtocol {
    static var reuseIdentifier: String = "TopCell"
    
    let containerView = UIView()
    let imageView = UIImageView()
    let title = UILabel()
    let seperator = UIView(frame: .zero)
    
    // MARK: super init neden kullanılır? ne işe yara?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Nesne tasarımını burada
        containerView.backgroundColor = .red
        containerView.layer.cornerRadius = 50
        containerView.translatesAutoresizingMaskIntoConstraints = false // tasarımı oluştururken sağ,sol vb. uzaklıkları ayarlamak için
        
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = .green
        
        title.font = UIFont.preferredFont(forTextStyle: .headline)
        title.textColor = .label
        
        let stackView = UIStackView(arrangedSubviews: [seperator, imageView, title])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.spacing = 10
        
        containerView.addSubview(stackView)
        
        //Autolayout
        NSLayoutConstraint.activate([
            seperator.heightAnchor.constraint(equalToConstant: 1),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), // contextView Cell in kalıbı. Sollar eşitlensin
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor), // Sağlar eşitlensin
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor) // Üstler aynı olsun
        ])
        
        stackView.setCustomSpacing(10, after: seperator) // özel boşluk
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with edevlet: EDevlet?) {
        // Nesne içeriğini burada
        title.text = edevlet?.name ?? ""
        imageView.image = UIImage(systemName: "star") // resim eklenince değiştir
    }
}
