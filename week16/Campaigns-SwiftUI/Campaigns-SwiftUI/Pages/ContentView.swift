//
//  ContentView.swift
//  Campaigns-SwiftUI
//
//  Created by Bahattin Koç on 16.04.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var fetchCampaigns = CampaignFetcher()
    
    var body: some View {
//        NavigationView {
//            List {
//                Text("SwiftUI Dersi")
//                Text("Android Dersi")
//                Text("iOS Dersi")
//            }.navigationTitle(Text("Ders Listesi")).navigationBarTitleDisplayMode(.automatic)
//        }
//        VStack {
//            Text("Hi world")
//                .font(.title)
//                .foregroundColor(.red)
//            Spacer()
//            Text("Hi moon")
//        }
        
        NavigationView {
            List {
                Text("Hi")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
