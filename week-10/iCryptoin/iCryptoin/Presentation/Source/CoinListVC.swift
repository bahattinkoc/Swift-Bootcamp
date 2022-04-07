//
//  ViewController.swift
//  iCryptoin
//
//  Created by Bahattin Koç on 16.03.2022.
//

import UIKit

final class CoinListVC: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - VARIABLES
    var coinRequest: CoinRequest?
    var isFiltered = false
    var coins = [CoinItem]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var filteredCoins = [CoinItem]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - INIT FUNCTIONS
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getCoinList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "CoinCell", bundle: nil), forCellWithReuseIdentifier: "coinCell")
    }
    
    // MARK: PRIVATE FUNCTIONS
    private func getCoinList() {
        coinRequest = CoinRequest()
        coinRequest?.getGameList(completion: { [weak self] result in
            guard let self = self else { return }
            
            if case .failure(let error) = result {
                switch error{
                case .noDataAvaible:
                    print("No Data Avaible")
                case .canNotProcessData:
                    print("Can Not Process Data")
                }
            } else if case .success(let list) = result {
                list.data?.coins?.forEach({ coin in
                    self.coins.append(CoinItem(model: coin))
                })
            }
        })
    }
}

// MARK: - EXTENSIONS

extension CoinListVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltered ? filteredCoins.count : coins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "coinCell", for: indexPath) as? CoinCell else { return UICollectionViewCell() }
        cell.configure(model: isFiltered ? filteredCoins[indexPath.row] : coins[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: CGFloat(80))
    }
}
