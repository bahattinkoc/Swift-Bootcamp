//
//  Section.swift
//  week6
//
//  Created by Bahattin Koç on 12.02.2022.
//

import Foundation

struct Section: Decodable, Hashable{
    let id: Int
    let type, title, subtitle: String
    let items: [EDevlet]
}
