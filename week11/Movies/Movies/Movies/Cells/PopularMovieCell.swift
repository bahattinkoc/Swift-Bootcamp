//
//  PopularMovieCell.swift
//  Movies
//
//  Created by Bahattin Koç on 19.03.2022.
//

import UIKit
import MoviesAPI
import SDWebImage

class PopularMovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(movie: Movie) {
        preparePosterImage(with: movie.posterPath)
        movieTitle.text = movie.title
    }
    
    private func preparePosterImage(with urlString: String?) {
        let fullPath = "https://image.tmdb.org/t/p/w200\(urlString ?? "")"
        if let url = URL(string: fullPath) {
            movieImage.sd_setImage(with: url, completed: nil)
        }
    }
}
