//
//  Collection.swift
//  MVVM
//
//  Created by Bahattin Koç on 6.04.2022.
//

extension Collection {
    func getAt(at index: Index?) -> Iterator.Element? {
        guard let index = index, indices.contains(index) else { return nil }
        return self[index]
    }
}
