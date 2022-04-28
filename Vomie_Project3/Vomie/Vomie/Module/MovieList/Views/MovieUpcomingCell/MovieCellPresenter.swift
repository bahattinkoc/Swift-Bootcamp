//
//  MovieCellPresenter.swift
//  Vomie
//
//  Created by Bahattin Koç on 27.04.2022.
//

//MARK: - PROTOCOLS
protocol MovieCellPresenterProtocol: AnyObject {
    func load()
}

//MARK: - CLASS
final class MovieCellPresenter {
    private weak var view: MovieCellProtocol?
    private let movie: Movie
    
    init(view: MovieCellProtocol?, movie: Movie) {
        self.view = view
        self.movie = movie
    }
}

//MARK: - EXTENSIONS
extension MovieCellPresenter: MovieCellPresenterProtocol {
    func load() {
        guard let title = movie.original_title else { return }
        view?.setTitle(title)
        guard let description = movie.overview else { return }
        view?.setDescription(description)
        guard let releaseDate = movie.release_date else { return }
        view?.setReleaseDate(releaseDate)
        guard let poster = movie.poster_path else { return }
        view?.setImage(poster)
    }
}
