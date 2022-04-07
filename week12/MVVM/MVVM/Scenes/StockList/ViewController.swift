//
//  ViewController.swift
//  MVVM
//
//  Created by Bahattin Koç on 26.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var stockInfo: Chart?
    private var resultModel = ResultStockModel()
    private var viewModel: StockListViewModelProtocol = StockListViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchRecordedStocks()
        viewModel.fetchStockInfo(stockName: "AKSA") // AKSA yazınısını nasıl almalı?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.resultModel = self.viewModel.fetchRecordedStock(name: "AKSA") ?? ResultStockModel()
            print(self.resultModel)
            let currentPrice = self.stockInfo?.result?.first?.meta?.regularMarketPrice
            self.resultModel.currentPrice = currentPrice
            let profitPrice = ((currentPrice ?? 0) - (self.resultModel.averagePrice ?? 0)) * (self.resultModel.currentCount ?? 0)
            let profitPercentage = (profitPrice / (self.resultModel.totalPrice ?? 0 - profitPrice)) * 100
            self.resultModel.profitPrice = profitPrice
            self.resultModel.profitPercentage = profitPercentage
        }
        
        collectionView.register(cellType: StockViewCell.self)
        viewModel.delegate = self
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: StockViewCell.self, indexPath: indexPath)
        //cell.configure(resultsStockModel: <#T##ResultStockModel#>)
        return cell
    }
}
extension ViewController: StockListViewModelDelegate {
    func updateList(with stock: Chart?) {
        self.stockInfo = stock
    }
}
