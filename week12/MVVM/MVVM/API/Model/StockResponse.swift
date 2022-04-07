//
//  StockResponse.swift
//  MVVM
//
//  Created by Bahattin Koç on 1.04.2022.
//

import Foundation

struct StockResponse: Codable {
    let chart: Chart?
}

// MARK: - Chart
struct Chart: Codable {
    let result: [StockDetail]?
}

// MARK: - Result
struct StockDetail: Codable {
    let meta: Meta?
    let timestamp: [Int]?
    let indicators: Indicators?
}

// MARK: - Indicators
struct Indicators: Codable {
    let quote: [Quote]?
}

// MARK: - Quote
struct Quote: Codable {
    let high, low: [Double?]?
    let volume: [Int?]?
    let quoteOpen, close: [Double?]?

    enum CodingKeys: String, CodingKey {
        case high, low, volume
        case quoteOpen = "open"
        case close
    }
}

// MARK: - Meta
struct Meta: Codable {
    let currency, symbol, exchangeName, instrumentType: String?
    let firstTradeDate, regularMarketTime, gmtoffset: Int?
    let timezone, exchangeTimezoneName: String?
    let regularMarketPrice, chartPreviousClose, previousClose: Double?
    let scale, priceHint: Int?
    let currentTradingPeriod: CurrentTradingPeriod?
    let tradingPeriods: [[Post]]?
    let dataGranularity, range: String?
    let validRanges: [String]?
}

// MARK: - CurrentTradingPeriod
struct CurrentTradingPeriod: Codable {
    let pre, regular, post: Post?
}

// MARK: - Post
struct Post: Codable {
    let timezone: String?
    let start, end, gmtoffset: Int?
}
