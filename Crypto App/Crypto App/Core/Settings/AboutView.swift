//
//  AboutView.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/8/24.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    Image("coingecko")
                        .resizable()
                    .frame(width: 140, height: 40)
                    Text("Data provided by CoinGecko")
                        .font(.subheadline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(Color.theme.secondaryText)
                    Text("CoinGecko provides a fundamental analysis of the crypto market. In addition to tracking price, volume and market capitalisation, CoinGecko tracks community growth, open-source code development, major events and on-chain metrics.")
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)
                    Link(destination: URL(string: "https://www.coingecko.com/")!, label: {
                        Text("CoinGecko")
                            .foregroundStyle(.blue)
                            .font(.callout)
                            .fontWeight(.semibold)
                    })
                    Spacer()
                    Link(destination: URL(string: "https://www.instagram.com/suvauny/")!, label: {
                        Text("App Developer")
                            .foregroundStyle(.blue)
                            .font(.caption)
                            .fontWeight(.semibold)
                    })
                }
                .padding()
                .padding(.top, 10)
                
                
                Spacer()
            }
            
            Spacer()
            
        }
    }
}

#Preview {
    AboutView()
}
