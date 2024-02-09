//
//  PortfolioView.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/8/24.
//

import SwiftUI

struct PortfolioView1: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(Color.theme.secondaryText)
            VStack {
                Text("Portfolio feature coming soon...")
            }
        }
    }
}

#Preview {
    PortfolioView()
}
