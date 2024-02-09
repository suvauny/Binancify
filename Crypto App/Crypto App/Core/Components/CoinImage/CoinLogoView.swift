//
//  CoinLogoView.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/7/24.
//

import SwiftUI

struct CoinLogoView: View {
    
    let coin: CryptoModel
    var body: some View {
        VStack {
            CryptoLogoView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CoinLogoView(coin: Preview.dev.coin)
}
