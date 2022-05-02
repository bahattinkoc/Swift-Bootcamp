//
//  MovieUpcomingCellViewTest.swift
//  VomieTests
//
//  Created by Bahattin Koç on 2.05.2022.
//

@testable import Vomie

final class MovieUpcomingCellViewTest: MovieCellProtocol {
    var invokeTitle = false
    var invokeDescription = false
    var invokeReleaseDate = false
    var invokeImage = false
    
    func setTitle(_ text: String) {
        invokeTitle = true
    }
    
    func setDescription(_ text: String) {
        invokeDescription = true
    }
    
    func setReleaseDate(_ text: String) {
        invokeReleaseDate = true
    }
    
    func setImage(_ urlString: String) {
        invokeImage = true
    }
}
