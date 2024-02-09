//
//  StatisticView.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/5/24.
//

import SwiftUI

struct StatsView: View {
    
    let stat: StatModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees:(stat.percentageChange ?? 0 ) >= 0 ? 0 : 180))
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .fontWeight(.bold)
            }
            .foregroundStyle((stat.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentageChange == nil ? 0 : 1)
        }
    }
}

#Preview {
    Group {
        StatsView(stat: Preview.dev.stat1)
        StatsView(stat: Preview.dev.stat2)
        StatsView(stat: Preview.dev.stat3)
    }
}
