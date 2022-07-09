//
//  ViewController.swift
//  Movies
//
//  Created by Bahattin Koç on 19.03.2022.
//

import UIKit

/*
 MVVM de ViewController da NetworkAPI kullanmamalıyız.
 */

// Bu classa ait constant oluşturacak isek burada oluşturalım


final class ViewController: UIViewController, LoadingShowable {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: ViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // MARK: ViewModel den filmleri almalıyız
        viewModel.load()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(cellType: PopularMovieCell.self)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: PopularMovieCell.self, indexPath: indexPath)
        if let movie = viewModel.movie(index: indexPath.row) {
            cell.configure(movie: movie)
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            .init(width: viewModel.calculateCellHeight(collectionViewWidth: collectionView.frame.size.width).width, height: viewModel.calculateCellHeight(collectionViewWidth: collectionView.frame.size.width).height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: .zero, left: viewModel.cellPadding, bottom: .zero, right: viewModel.cellPadding)
    }
}

extension ViewController: ViewModelDelegate {
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}
