//
//  FavoritesVC.swift
//  PinGame
//
//  Created by Bahattin Koç on 11.03.2022.
//

import UIKit

class FavoritesVC: UIViewController {

    @IBOutlet weak var notFoundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var isFiltered = false
    var filteredFavoriteGames = [GameItem](){
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var favoriteGames = [GameItem](){
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        collectionView.register(UINib(nibName: "GameListItemCell", bundle: nil), forCellWithReuseIdentifier: "gameItemCell")
        
        loadFavoriteGames()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favorite Games"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    private func loadFavoriteGames(){
        favoriteGames.removeAll()
        for game in Global.instance.games{
            if game.isLike{
                favoriteGames.append(game)
            }
        }
        
        if favoriteGames.count == 0{
            setHidden(notFound: false, collectionView: true)
        } else {
            setHidden(notFound: true, collectionView: false)
        }
    }
    
    func setHidden(notFound: Bool, collectionView: Bool){
        self.notFoundImageView.isHidden = notFound
        self.collectionView.isHidden = collectionView
    }
}

extension FavoritesVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltered ? filteredFavoriteGames.count : favoriteGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameItemCell", for: indexPath) as! GameListItemCell
        cell.configure(model: (isFiltered) ? filteredFavoriteGames[indexPath.row] : favoriteGames[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width), height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Global.instance.selectedGame = (isFiltered) ? filteredFavoriteGames[indexPath.row] : favoriteGames[indexPath.row]
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Pin.StoryboardID.detailPageVC)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}


extension FavoritesVC: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isFiltered = false
        notFoundImageView.isHidden = true
        searchBar.text = ""
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines) != "" && searchText.trimmingCharacters(in: .whitespacesAndNewlines).count >= 3{
            filteredFavoriteGames = favoriteGames.filter({ (game: GameItem) in
                return game.name.localizedLowercase.contains(searchText.localizedLowercase)
            })
            
            if filteredFavoriteGames.count == 0{
                setHidden(notFound: false, collectionView: true)
            } else {
                setHidden(notFound: true, collectionView: false)
            }
            
            self.isFiltered = true
        } else {
            self.isFiltered = false
            setHidden(notFound: true, collectionView: false)
        }
        
        collectionView.reloadData()
    }
}
