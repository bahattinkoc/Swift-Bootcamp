//
//  SearchedMovieCell.swift
//  Vomie
//
//  Created by Bahattin Koç on 29.04.2022.
//

import UIKit

//MARK: - PROTOCOLS
protocol SearhedMovieCellProtocol: AnyObject {
    func setTitle(_ text: String)
}

//MARK: - CLASS
final class SearchedMovieCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    
    var cellPresenter: SearchedMovieCellPresenterProtocol! {
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
extension SearchedMovieCell: SearhedMovieCellProtocol {
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
}
