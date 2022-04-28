//
//  CampaignRow.swift
//  Campaigns-SwiftUI
//
//  Created by Bahattin Koç on 16.04.2022.
//

import SwiftUI

struct CampaignRow: View {
    var campaign: Campaign
    var body: some View {
        HStack {
            ImageURL(url: campaign.resim ?? "")
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(campaign.baslik ?? "")
                    .fontWeight(.medium)
                Text(campaign.tarih ?? "")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }.padding()
        }
    }
}

struct CampaignRow_Previews: PreviewProvider {
    static var previews: some View {
        CampaignRow(campaign: Campaign.example)
    }
}
