//
//  Campaign.swift
//  Campaigns-SwiftUI
//
//  Created by Bahattin Koç on 16.04.2022.
//

import Foundation

struct Campaign: Decodable {
    let id: String?
    let baslik: String?
    let icerik: String?
    let tarih: String?
    let resim: String?
    let durum: String?
    
    var imageURL: URL {
        URL(string: resim ?? "")!
    }
    
    #if DEBUG
    // Bir örnek koymak gerekiyordu
    static let example = Campaign(id: "1", baslik: "ExampleName", icerik: "ExampleIcerik", tarih: "ExampleDate", resim: "ExampleImage", durum: "ExampleDurum")
    #endif
}
