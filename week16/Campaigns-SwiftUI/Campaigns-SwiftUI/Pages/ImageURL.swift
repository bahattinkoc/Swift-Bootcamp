//
//  ImageURL.swift
//  Campaigns-SwiftUI
//
//  Created by Bahattin Koç on 16.04.2022.
//

import SwiftUI

struct ImageURL: View {
    @ObservedObject var imageLoader = ImageLoader()
    var placeholder: Image
    
    init(url: String, placeholder: Image = Image(systemName: "star")) {
        self.placeholder = placeholder
        self.imageLoader.loadImage(from: url)
    }
    
    var body: some View {
        if let uiImage = self.imageLoader.downloadedImag {
            
        }
    }
}
