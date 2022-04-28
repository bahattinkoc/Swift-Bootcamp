//
//  NowPlayingPresenter.swift
//  Vomie
//
//  Created by Bahattin Koç on 27.04.2022.
//

//MARK: - PROTOCOLS
protocol NowPlayingCellPresenterProtocol: AnyObject {
    func load()
}

//MARK: - CLASS
final class NowPlayingCellPresenter {
    private weak var view: NowPlayingCellProtocol?
    private let movie: Movie
    
    init(view: NowPlayingCellProtocol?, movie: Movie) {
        self.view = view
        self.movie = movie
    }
}

//MARK: - EXTENSIONS
extension NowPlayingCellPresenter: NowPlayingCellPresenterProtocol {
    func load() {
        guard let poster = movie.poster_path else { return }
        view?.setImage(poster)
        guard let title = movie.original_title else { return }
        view?.setTitle(title)
    }
}
