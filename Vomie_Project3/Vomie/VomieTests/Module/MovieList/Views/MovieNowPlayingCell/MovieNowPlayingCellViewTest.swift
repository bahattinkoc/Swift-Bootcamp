//
//  MovieNowPlayingCellViewTest.swift
//  VomieTests
//
//  Created by Bahattin Koç on 2.05.2022.
//

@testable import Vomie

final class NowPlayingCellViewTest: NowPlayingCellProtocol {
    var invokeSetTitle = false
    var invokeSetImage = false
    
    func setTitle(_ text: String) {
        invokeSetTitle = true
    }
    
    func setImage(_ urlString: String) {
        invokeSetImage = true
    }
}
