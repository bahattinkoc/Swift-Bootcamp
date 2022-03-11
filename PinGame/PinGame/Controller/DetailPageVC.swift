//
//  DetailPageVC.swift
//  PinGame
//
//  Created by Bahattin Koç on 11.03.2022.
//

import UIKit

class DetailPageVC: UIViewController {

    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var metacriticLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    
    var game = Global.instance.selectedGame
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        
        nameLabel.text = game?.name
        releaseLabel.text = "Release Date: \(game?.released ?? "")"
        gameImageView.image = game?.image
        metacriticLabel.text = "Metacritic Rate: \(game?.metacritic ?? -1)"
        detailTextView.text = game?.description
        
        likeImageView.isUserInteractionEnabled = true
        let likeTap = UITapGestureRecognizer(target: self, action: #selector(likeAction))
        likeImageView.addGestureRecognizer(likeTap)
        
        likeImageTint()
    }
    
    private func likeImageTint(){
        likeImageView.tintColor = game?.isLike ?? false ? .systemRed : .white
    }
    
    @objc private func likeAction(){
        game?.isLike = !(game?.isLike ?? false)
        likeImageTint()
        DispatchQueue.main.async {
            Global.instance.updateLike(id: self.game?.id ?? 1, isLike: self.game?.isLike ?? false)
            
            Global.instance.selectedGame = Global.instance.games.first(where: { item in
                item.id == self.game?.id
            })
            Global.instance.showAll()
        }
    }
}
