//
//  SimilarCellPresenter.swift
//  Vomie
//
//  Created by Bahattin Koç on 28.04.2022.
//

//MARK: - PROTOCOLS
protocol SimilarCellPresenterProtocol: AnyObject {
    func load()
}

//MARK: - CLASS
final class SimilarCellPresenter {
    private weak var view: SimilarCellProtocol?
    private let movie: Movie

    init(view: SimilarCellProtocol, movie: Movie) {
        self.view = view
        self.movie = movie
    }
}

//MARK: - EXTENSIONS
extension SimilarCellPresenter: SimilarCellPresenterProtocol {
    func load() {
        
        guard let poster = movie.poster_path else { return }
        self.view?.setImage(poster)
        
        guard let title = movie.original_title else { return }
        view?.setTitle(title)
    }
}
