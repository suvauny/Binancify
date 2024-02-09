//
//  CoinImageView.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/5/24.
//

import SwiftUI


struct CryptoLogoView: View {
    
    @StateObject var vm: CyptoLogoModel
    
    init(coin:CryptoModel) {
        _vm = StateObject(wrappedValue: CyptoLogoModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            else if vm.isLoading {
                ProgressView()
            }
            else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondaryText)
            }
        }
    }
}

#Preview {
    CryptoLogoView(coin: Preview.dev.coin)
        .previewLayout(.sizeThatFits)
        .padding()
}
