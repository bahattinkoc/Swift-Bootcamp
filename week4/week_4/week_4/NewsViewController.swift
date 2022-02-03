//
//  NewsViewController.swift
//  week_4
//
//  Created by Bahattin Koç on 29.01.2022.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var news = [NewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        let news1 = NewsModel(newImg: #imageLiteral(resourceName: "turkcell1"), title: "Title 1", detail: "Detail 1")
        let news2 = NewsModel(newImg: #imageLiteral(resourceName: "turkcell3"), title: "Title 2", detail: "Detail 2")
        let news3 = NewsModel(newImg: #imageLiteral(resourceName: "turkcell2"), title: "Title 3", detail: "Detail 3")
        
        news = [news1, news2, news3]
    }
}

extension NewsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! NewsCell
//        cell.configure(model: news[indexPath.row])
        return UICollectionViewCell()
    }
    
    
}
