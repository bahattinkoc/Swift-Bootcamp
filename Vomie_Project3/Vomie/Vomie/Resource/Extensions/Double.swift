//
//  Double.swift
//  Vomie
//
//  Created by Bahattin Koç on 4.05.2022.
//

import Foundation

extension Double {
    func round(_ basamak: Int) -> Double{
        let carpan = pow(10.0, Double(basamak))
        return (self * carpan).rounded() / carpan
    }
}
