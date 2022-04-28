//
//  MovieDetailViewController.swift
//  CIViperGenerator
//
//  Created by Bahattin on 26.04.2022.
//  Copyright © 2022 Bahattin. All rights reserved.
//

import UIKit

//MARK: - PROTOCOLS
protocol MovieDetailViewControllerProtocol: AnyObject {
    func reloadData()
    func setupCollectionView()
    func setTitle(_ text: String)
    func setMovieTitle(_ text: String)
    func setMovieOverview(_ text: String)
    func setRate(_ text: String)
    func setReleaseDate(_ text: String)
    func setMoviePoster(_ urlString: String)
    func setFavoriteStatus(_ status: Bool)
}

//MARK: - CLASS
final class MovieDetailViewController: UIViewController {
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var overviewTextView: UITextView!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var imdbImageView: UIImageView!
    @IBOutlet private weak var similarCollectionView: UICollectionView!
    @IBOutlet private weak var favoriteImageView: UIImageView!
    
    var presenter: MovieDetailPresenterProtocol!
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movie = movie else { return }
        presenter.viewDidLoad(movie: movie)
        setupIMDB()
        setupFavoriteButton()
    }
    
    //MARK: - PRIVATES FUNCTIONS
    private func setupIMDB() {
        imdbImageView.isUserInteractionEnabled = true
        imdbImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imdbTap)))
    }
    
    private func setupFavoriteButton() {
        favoriteImageView.isUserInteractionEnabled = true
        favoriteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favoriteTap)))
    }
    
    //MARK: - OBJC FUNCTIONS
    @objc private func imdbTap() {
        presenter.gotoIMDB()
    }
    
    @objc private func favoriteTap() {
        presenter.toggleFavorite()
    }
}

//MARK: - EXTENSIONS
extension MovieDetailViewController: MovieDetailViewControllerProtocol {
    func setFavoriteStatus(_ status: Bool) {
        favoriteImageView.image = status ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }
    
    func setMoviePoster(_ urlString: String) {
        posterImageView.pullImageFromTheMovieDB(urlString)
    }
    
    func setReleaseDate(_ text: String) {
        releaseDateLabel.text = text
    }
    
    func setMovieTitle(_ text: String) {
        titleLabel.text = text
    }
    
    func setMovieOverview(_ text: String) {
        overviewTextView.text = text
    }
    
    func setRate(_ text: String) {
        rateLabel.text = text
    }
    
    func setTitle(_ text: String) {
        title = text
    }
    
    func reloadData() {
        similarCollectionView.reloadData()
    }
    
    func setupCollectionView() {
        similarCollectionView.dataSource = self
        similarCollectionView.delegate = self
        similarCollectionView.register(cellType: SimilarCell.self)
    }
}

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.similarMoviesCount() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = similarCollectionView.dequeCell(cellType: SimilarCell.self, indexPath: indexPath)
        if let movie = presenter.getSimilarMovie(index: indexPath.row) {
            cell.cellPrensenter = SimilarCellPresenter(view: cell, movie: movie)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
}

