//
//  NowPlayingCell.swift
//  Vomie
//
//  Created by Bahattin Koç on 27.04.2022.
//

import UIKit

//MARK: - PROTOCOLS
protocol NowPlayingCellProtocol: AnyObject {
    func setTitle(_ text: String)
    func setImage(_ urlString: String)
}

//MARK: - CLASS
final class NowPlayingCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var movieTitle: UILabel!
    
    var cellPresenter: NowPlayingCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

//MARK: - EXTENSIONS
extension NowPlayingCell: NowPlayingCellProtocol {
    func setTitle(_ text: String) {
        movieTitle.text = text
    }
    
    func setImage(_ urlString: String) {
        imageView.pullImageFromTheMovieDB(urlString)
    }
}
