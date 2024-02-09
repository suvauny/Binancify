//
//  CoinRowView.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/5/24.
//

import SwiftUI

struct CryptoRowView: View {
    
    let coin:CryptoModel
    let showHoldingsColumn: Bool
    
    
    var body: some View {
    
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("\(coin.rank)")
                    .font(.caption)
                    .foregroundStyle(Color.theme.secondaryText)
                    .frame(minWidth: 30)
                CryptoLogoView(coin: coin)
                    .frame(width: 30, height: 30)
                Text(coin.symbol.uppercased())
                    .font(.headline)
                    .padding(.leading, 6)
                    .foregroundStyle(Color.theme.accent)
            }
            Spacer()
            /// original
            /*
            if showHoldingsColumn {
             VStack(alignment: .trailing) {
                 Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                     .bold()
                 Text((coin.currentHoldings ?? 0).asNumberString())
             }
             .foregroundStyle(Color.theme.accent)
            }
            */
            VStack(alignment: .trailing) {
                Text(coin.currentPrice.asCurrencyWith6Decimals())
                    .bold()
                    .foregroundStyle(Color.theme.accent)
                Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                    .foregroundStyle(
                        (coin.priceChangePercentage24H ?? 0) >= 0 ?
                        Color.theme.green :
                        Color.theme.red
                    )
            }
            .frame(width: (Screen.getScreenBounds()?.bounds.width ?? 0)/3.5, alignment: .trailing)
        }
        .font(.subheadline)
        .background(
            Color.theme.background.opacity(0.001)
        )
    }
}

#Preview {
    CryptoRowView(coin: Preview.dev.coin, showHoldingsColumn: true)
}

extension CryptoRowView {
    
}
