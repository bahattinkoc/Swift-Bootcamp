//
//  SearchedMovieCellPresenter.swift
//  Vomie
//
//  Created by Bahattin Koç on 29.04.2022.
//

//MARK: - PROTOCOLS
protocol SearchedMovieCellPresenterProtocol: AnyObject {
    func load()
}

//MARK: - CLASS
final class SearchedMovieCellPresenter {
    private weak var view: SearhedMovieCellProtocol?
    private let movie: Movie
    
    init(view: SearhedMovieCellProtocol?, movie: Movie) {
        self.view = view
        self.movie = movie
    }
}

//MARK: - EXTENSIONS
extension SearchedMovieCellPresenter: SearchedMovieCellPresenterProtocol {
    func load() {
        guard let title = movie.original_title else { return }
        view?.setTitle(title)
    }
}
