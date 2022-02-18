//
//  EDevletCellProtocol.swift
//  week6
//
//  Created by Bahattin Koç on 11.02.2022.
//

import Foundation

protocol EDevletCellProtocol{
    static var reuseIdentifier: String { get }
    func configure(with edevlet: EDevlet?)
}
