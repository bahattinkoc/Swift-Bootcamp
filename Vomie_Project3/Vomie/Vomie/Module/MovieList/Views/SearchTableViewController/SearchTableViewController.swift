//
//  SearchTableViewController.swift
//  Vomie
//
//  Created by Bahattin Koç on 29.04.2022.
//

import UIKit

final class SearchTableViewController: UITableViewController {
    private var presenter: MovieListPresenterProtocol!
    
    init(presenter: MovieListPresenterProtocol) {
        super.init(style: .plain)
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.searchedMoviesCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeCell(cellType: SearchedMovieCell.self, indexPath: indexPath)
        cell.selectionStyle = .none
        if let movie = presenter.getSearchedMovies(index: indexPath.row) {
            cell.cellPresenter = SearchedMovieCellPresenter(view: cell, movie: movie)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row, list: .searched)
    }
}
