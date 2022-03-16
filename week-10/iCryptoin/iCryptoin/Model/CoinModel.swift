//
//  Coin.swift
//  iCryptoin
//
//  Created by Bahattin Koç on 16.03.2022.
//

struct CoinModel: Decodable {
    let status: String?
    let data: DataModel?
}

struct DataModel: Decodable {
    let coins: [Coin]?
}

struct Coin: Decodable {
    let uuid: String?
    let symbol: String?
    let name: String?
    let color: String?
    let iconUrl: String?
    let marketCap: String?
    let price: String?
    let listedAt: CLong?
    let tier: Int?
    let change: String?
    let rank: Int?
    let lowVolume: Bool?
    let coinrankingUrl: String?
    let the24hVolume: String?
    let btcPrice: Double?
    let sparkline: [String]?
}


