//
//  Extensions.swift
//  Campaigns-SwiftUI
//
//  Created by Bahattin Koç on 16.04.2022.
//

import SwiftUI

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars {
            print(v)
        }
        return EmptyView()
    }
}
