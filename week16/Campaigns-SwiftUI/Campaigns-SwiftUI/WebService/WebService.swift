//
//  WebService.swift
//  Campaigns-SwiftUI
//
//  Created by Bahattin Koç on 16.04.2022.
//

import Foundation
import UIKit

final class CampaignFetcher: ObservableObject {
    @Published var campaigns = [Campaign]()
    
    init() {
        loadCampaigns()
    }
    
    private func loadCampaigns() {
        let url = URL(string: "http://www.bucayapimarket.com/json.php")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                let campaigns = try JSONDecoder().decode([Campaign].self, from: data!)
                self.campaigns = campaigns
            } catch {
                print("Error")
            }
        }.resume()
    }
}

final class ImageLoader: ObservableObject {
    @Published var data: Data?
    var downloadedImag: UIImage?
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                self.data = data
                self.downloadedImag = UIImage(data: data)
            } catch {
                print("download error")
            }
        }.resume()
    }
}
