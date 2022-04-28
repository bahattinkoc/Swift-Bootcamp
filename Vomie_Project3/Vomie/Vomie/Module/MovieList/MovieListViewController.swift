//
//  MovieListViewController.swift
//  CIViperGenerator
//
//  Created by Bahattin on 26.04.2022.
//  Copyright © 2022 Bahattin. All rights reserved.
//

import UIKit

//MARK: - PROTOCOLS
protocol MovieListViewControllerProtocol: AnyObject {
    func reloadData()
    func setupTableView()
    func setupCollectionView()
    func setupPageController(count: Int)
    func setupSearchController()
    func setTitle(_ text: String)
    func changeSlideWithPageControl(index: Int)
    var getSearchController: UISearchController { get }
}

//MARK: - CLASS
final class MovieListViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    var presenter: MovieListPresenterProtocol!
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @IBAction func pageControllerClicked(_ sender: UIPageControl) {
        presenter.pageControlTapped(index: sender.currentPage)
    }
}

//MARK: - EXTENSIONS
extension MovieListViewController: MovieListViewControllerProtocol {
    var getSearchController: UISearchController {
        searchController
    }
    
    func setupSearchController() {
        searchController.searchBar.placeholder = "Search Movie"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func changeSlideWithPageControl(index: Int) {
        collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func setTitle(_ text: String) {
        title = text
    }
    
    func setupPageController(count: Int) {
        pageControl.currentPage = 0
        pageControl.numberOfPages = count
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: MovieCell.self)
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellType: NowPlayingCell.self)
    }
    
    func reloadData() {
        tableView.reloadData()
        collectionView.reloadData()
    }
}

extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter.filterSearchMoviesForSearchText(searchController.searchBar.text ?? "")
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.upcomingCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeCell(cellType: MovieCell.self, indexPath: indexPath)
        cell.selectionStyle = .none
        if let movie = presenter.getUpcomingMovie(index: indexPath.row) {
            cell.cellPresenter = MovieCellPresenter(view: cell, movie: movie)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row, list: .upcoming)
    }
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.nowPlayingCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: NowPlayingCell.self, indexPath: indexPath)
        if let movie = presenter.getNowPlayingMovie(index: indexPath.row) {
            cell.cellPresenter = NowPlayingCellPresenter(view: cell, movie: movie)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row, list: .nowPlaying)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / view.frame.width)
    }
}
