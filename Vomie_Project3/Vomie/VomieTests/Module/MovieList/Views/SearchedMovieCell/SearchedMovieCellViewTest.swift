//
//  SearchedMovieCellViewTest.swift
//  VomieTests
//
//  Created by Bahattin Koç on 2.05.2022.
//

@testable import Vomie

final class SearchedMovieCellViewTest: SearhedMovieCellProtocol {
    var invokeSetTitle = false
    
    func setTitle(_ text: String) {
        invokeSetTitle = true
    }
}
