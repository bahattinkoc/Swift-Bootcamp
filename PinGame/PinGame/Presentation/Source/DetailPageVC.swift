//
//  DetailPageVC.swift
//  PinGame
//
//  Created by Bahattin Koç on 11.03.2022.
//

import UIKit

final class DetailPageVC: UIViewController {

    // MARK: - OUTLETS

    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var likeImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var releaseLabel: UILabel!
    @IBOutlet private weak var metacriticLabel: UILabel!
    @IBOutlet private weak var detailTextView: UITextView!

    // MARK: - PROPERTIES

    private var game = CoreDataHelper.instance.selectedGame

    // MARK: - LIFE CYCLE METHODS

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        prepareUI()
    }

    // MARK: - PREPARE UI

    private func prepareUI() {
        guard let game = game else { return }
        nameLabel.text = game.name
        releaseLabel.text = "Release Date: \(game.released)"
        gameImageView.image = game.image
        metacriticLabel.text = "Metacritic Rate: \(game.metacritic)"
        detailTextView.attributedText = game.description.htmlToAttributedString
        prepareLikeImage()
    }

    private func prepareLikeImage() {
        likeImageView.isUserInteractionEnabled = true
        let likeTap = UITapGestureRecognizer(target: self, action: #selector(likeAction))
        likeImageView.addGestureRecognizer(likeTap)
        
        likeImageView.clipsToBounds = false
        likeImageView.layer.shadowColor = UIColor.black.cgColor
        likeImageView.layer.shadowOpacity = 1
        likeImageView.layer.shadowOffset = CGSize.zero
        likeImageView.layer.shadowRadius = 10
        
        likeImageTint()
    }

    private func likeImageTint() {
        likeImageView.tintColor = game?.isLike ?? false ? .systemRed : .white
    }

    // MARK: - SELECTORS

    @objc private func likeAction() {
        guard let game = game else { return }
        game.isLike.toggle()
        likeImageTint()
        DispatchQueue.main.async {
            CoreDataHelper.instance.updateLike(id: game.id, isLike: game.isLike)
            CoreDataHelper.instance.selectedGame = CoreDataHelper.instance.games.first(where: { $0.id == game.id } )
        }
    }
}


// MARK: - EXTENSIONS
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
