//
//  HomeStatsView.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/5/24.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm:Home
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatsView(stat: stat)
                    .frame(width: (Screen.getScreenBounds()?.bounds.width ?? 0) / 3)
            }
        }
        .frame(width: (Screen.getScreenBounds()?.bounds.width ?? 0),
               alignment: showPortfolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatsView(showPortfolio: .constant(false))
        .environmentObject(Preview.dev.homeVM)
}
