//
//  DetailView.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/7/24.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CryptoModel?
    @Binding var showingDetail:Bool
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin, showDetail1: $showingDetail)
            }
        }
        
    }
}

struct DetailView: View {
    
    @Binding var showDetail:Bool
    @StateObject private var vm: Detail
    @State private var showFullDescription: Bool = false
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing:CGFloat = 30
    
    init(coin: CryptoModel, showDetail1:Binding<Bool>) {

        _vm = StateObject(wrappedValue: Detail(coin: coin))
        _showDetail = showDetail1
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        ChartView(coin: vm.coin)
                            .padding(.vertical)
                        
                        VStack(spacing: 20) {
                            overviewTitle
                            Divider()
                            descriptionSection
                            
                            overviewGrid
                            additionalTitle
                            Divider()
                            additionalGrid
                            websiteSection
                        }
                        .padding()
                    }
                }
                .navigationTitle(vm.coin.name)
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        navigationBarTrailingItems
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            showDetail = false
                        }, label: {
                            Image(systemName: "xmark")
                                .font(.callout)
                                .fontWeight(.semibold)
                        })
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(coin: Preview.dev.coin, showDetail1: .constant(true))
    }
}


extension DetailView {
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
            .foregroundStyle(Color.theme.secondaryText)
            CryptoLogoView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var descriptionSection: some View {
        ZStack {
            if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)
                    
                    Button(action: {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    }, label: {
                        Text(showFullDescription ? "Less.." : "Read More..")
                    })
                    .tint(.blue)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.vertical, 4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            
            }
        }
    }
    
    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.overviewStatistics) { stat in
                    StatsView(stat: stat)
                }
        })
    }
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.additionalStatistics) { stat in
                    StatsView(stat: stat)
                }
        })
    }
    
    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let websiteString = vm.websiteURL,
               let url = URL(string: websiteString) {
                Link("Website", destination: url)
            }
            
            if let redditString = vm.redditURL, let url = URL(string: redditString) {
                Link("Reddit", destination: url)
            }
        }
        .tint(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
}
