//
//  FavoritesVC.swift
//  PinGame
//
//  Created by Bahattin Koç on 11.03.2022.
//

import UIKit

final class FavoritesVC: UIViewController {

    @IBOutlet private weak var notFoundImageView: UIImageView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    // MARK - PROPERTIES
    
    var isFiltered = false
    var filteredFavoriteGames = [GameItem]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var favoriteGames = [GameItem]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - EXTERNAL FUNCTIONS
    
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
    
    // MARK: - PRIVATE FUNCTIONS
    
    private func loadFavoriteGames() {
        favoriteGames.removeAll()
        
        CoreDataHelper.instance.games.forEach { item in
            if item.isLike {
                favoriteGames.append(item)
            }
        }

        favoriteGames.isEmpty ? setHidden(notFound: false, collectionView: true) : setHidden(notFound: true, collectionView: false)
    }
    
    private func setHidden(notFound: Bool, collectionView: Bool) {
        notFoundImageView.isHidden = notFound
        self.collectionView.isHidden = collectionView
    }
}

// MARK: - EXTENSIONS

extension FavoritesVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltered ? filteredFavoriteGames.count : favoriteGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameItemCell", for: indexPath) as? GameListItemCell else { return .init() }
        cell.configure(model: isFiltered ? filteredFavoriteGames[indexPath.row] : favoriteGames[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        CoreDataHelper.instance.selectedGame = isFiltered ? filteredFavoriteGames[indexPath.row] : favoriteGames[indexPath.row]
        pushVC(storyboardName: "Main", storyboardId: .detailPageVC)
    }
}

extension FavoritesVC: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltered = false
        notFoundImageView.isHidden = true
        searchBar.text = ""
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines) != "" && searchText.trimmingCharacters(in: .whitespacesAndNewlines).count >= 3 {
            filteredFavoriteGames = favoriteGames.filter({ game in
                return game.name.localizedLowercase.contains(searchText.localizedLowercase)
            })
            
            filteredFavoriteGames.isEmpty ? setHidden(notFound: false, collectionView: true) : setHidden(notFound: true, collectionView: false)
            
            isFiltered = true
        } else {
            isFiltered = false
            setHidden(notFound: true, collectionView: false)
        }
        
        collectionView.reloadData()
    }
}
