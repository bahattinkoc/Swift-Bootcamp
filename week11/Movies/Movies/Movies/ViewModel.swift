//
//  ViewModel.swift
//  Movies
//
//  Created by Bahattin Koç on 25.03.2022.
//

// ViewModelde UIKit olmayacak
// Controllerde API olmayacak

/*
 MVVM de View Modelde UIKit kullanmamalıyız. (Kesin bir yolu vardır düşün.)
 */

import Foundation
import MoviesAPI

extension ViewModel {
    fileprivate enum Constants {
        static let cellTitleHeight: Double = 50
        static let cellPosterImageRatio: Double = 0.5
        static let cellLeftPadding: Double = 15
        static let cellRightPadding: Double = 15
    }
}

// Karşıdan alacak isek Protocol eklenir
protocol ViewModelProtocol {
    var delegate: ViewModelDelegate? { get set }
    var numberOfItems: Int { get }
    var cellPadding: Double { get }
    func load()
    func movie(index: Int) -> Movie?
    func calculateCellHeight(collectionViewWidth: Double) -> (width: Double, height: Double)
}

// Gönderecek isek sonuna Delegate eklenir
protocol ViewModelDelegate: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
}

final class ViewModel {
    private var movies: [Movie] = []
    let service: MovieServiceProtocol
    weak var delegate: ViewModelDelegate?
    
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    
    fileprivate func fetchMovies() {
        // showLoading() MARK: ViewController da loading göstermesini SÖYLE -> Delegate
        self.delegate?.showLoadingView()
        
        service.fetchPopularMovies { [weak self] response in
            guard let self = self else { return }
            // self.hideLoading() MARK: ViewController da loadingi gizlemesini SÖYLE -> Delegate
            self.delegate?.hideLoadingView()
            
            switch response {
            case .success(let movies):
                print(movies)
                self.movies = movies
                
                // reloadData MARK: ViewController da collectionView ı yenilemesini SÖYLE -> Delegate
                self.delegate?.reloadData()
            case.failure(let error):
                print(error)
            }
        }
    }
}

extension ViewModel: ViewModelProtocol {
    var numberOfItems: Int {
        movies.count
    }
    
    var cellPadding: Double {
        Constants.cellLeftPadding
    }
    
    func load() {
        fetchMovies()
    }
    
    func movie(index: Int) -> Movie? {
        movies[index] // MARK: safe subscript yap
    }
    
    func calculateCellHeight(collectionViewWidth: Double) -> (width: Double, height: Double) {
        let cellWidth = collectionViewWidth - (Constants.cellLeftPadding + Constants.cellRightPadding)
        let posterImageHeight = cellWidth * Constants.cellPosterImageRatio
        return (width: cellWidth, height: Constants.cellTitleHeight + posterImageHeight)
    }
}
