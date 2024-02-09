//
//  HomeView.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/5/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: Home
    @State private var showPortFolio: Bool = false // animate right
    @State private var showPortfolioView: Bool = false // new sheet
    @State private var showSettingsView: Bool = false
    
    @State private var selectedCoin: CryptoModel? = nil
    @State var showDetailView: Bool = false
    @State var showAlert: Bool = false
    @State var showSearchBar:Bool = false
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                // background layer
                Color(Color.theme.background)
                    .ignoresSafeArea()
                    .sheet(isPresented: $showPortfolioView, content: {
                        PortfolioView()
                            .environmentObject(vm)
                    })
                    .sheet(isPresented: $showSettingsView, content: {
                        SettingsView()
                    })

                // content layer
                VStack {
                    
                    HStack {
                        HStack {
                            Image(systemName: showPortFolio ? "plus": "person")
                                .font(.headline)
                                .foregroundStyle(Color.theme.accent)
                                .frame(width:50, height: 50)
                                .shadow(color: Color.theme.accent.opacity(0.25),
                                        radius: 10)
                                .padding()
                                .onTapGesture {
                                    if showPortFolio {
                                        showPortfolioView.toggle()
                                    }
                                    else {
                                        showSettingsView.toggle()
                                    }
                                }
                        }
                        
                        Spacer()
                        VStack {
                            Image("binanCapLogo")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.blue)
                            Text(showPortFolio ? "Watch List" : "Binancify")
                                .animation(.none, value: false)
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundStyle(Color.theme.accent)
                        }
                        Spacer()
                        HStack(spacing: 0) {
                            Image(systemName: "magnifyingglass")
                                .font(.headline)
                                .foregroundStyle(Color.theme.accent)
                                .shadow(color: Color.theme.accent.opacity(0.25),
                                        radius: 10)
                                .onTapGesture {
                                    withAnimation(.spring) {
                                        showSearchBar.toggle()
                                    }
                                }
                            
                            Image(systemName: showPortFolio ? "arrow.backward" : "eye")
                                .font(.headline)
                                .foregroundStyle(Color.theme.accent)
                                .frame(width:50, height: 50)
                                .shadow(color: Color.theme.accent.opacity(0.25),
                                        radius: 10)
                                .onTapGesture {
                                    withAnimation(.spring) {
                                        showPortFolio.toggle()
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                    // If there's no adImage then database is empty
                    // Don't show adsImage
                    if vm.adImage != nil {
                        adsImage
                            .padding(.bottom)
                    }
                    HomeStatsView(showPortfolio: $showPortFolio)
                        .padding(.bottom, 10)
                    if showSearchBar {
                        SearchBarView(searchText: $vm.searchText)
                    }
                    
                    columnTitles
                    
                    if !showPortFolio {
                        allCoinsList
                            .transition(.move(edge: .leading))
                    }
                    else {
                        portfolioList
                            .transition(.move(edge: .trailing))
                    }
                    Spacer(minLength: 0)
                }
            }
            .onAppear() {
                // Timer countdown to display alert
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 120) {
                    
                    // Set vm.alert to nil so that the alert doesn't get recalled everytime the view appears
                    if vm.alert != nil {
                        showAlert = true
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
                            vm.alert = nil
                        }
                    }
                }
            }
            .alert(isPresented: $showAlert) { () -> Alert in
                let primary = Alert.Button.default(Text("Visit")) {
                            if let url = URL(string: vm.alert?.url ?? "") {
                                UIApplication.shared.open(url)
                            }
                        }
                        let secondary = Alert.Button.default(Text("Close"))
                return Alert(title: Text(vm.alert?.title ?? ""), message: Text(vm.alert?.message ?? ""), primaryButton: primary,secondaryButton: secondary)
             }
            .fullScreenCover(isPresented: $showDetailView, content: {
                DetailLoadingView(coin: $selectedCoin, showingDetail: $showDetailView)
            })
        }
        
    }
}

#Preview {
    NavigationStack {
        HomeView()
            
            //.toolbar(.hidden)
    }
    .environmentObject(Preview.dev.homeVM)
}


extension HomeView {
    
    private var adsImage: some View {
        VStack {
            if vm.showAd {
                // Remove ad if user is viewing portfolio
                if !showPortFolio {
                    Image(uiImage: vm.adImage ?? UIImage(systemName: "photo.fill")!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: (Screen.getScreenBounds()?.bounds.size.width)! - 30, height: (Screen.getScreenBounds()?.bounds.size.width)! / 2)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.top, 11)
                        .padding(.bottom, 10)
                        .clipped()
                        .shadow(color: Color.theme.accent.opacity(0.3), radius: 10)
                        .onTapGesture {
                            guard let url = vm.adURL else { return }
                            UIApplication.shared.open(url)
                        }
                }
            }
//            else {
//                ProgressView()
//                    .frame(width: 100, height: 200)
//            }
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.easeIn) {
                // initializes and animation to load the adsImage before alert
                timer.upstream.connect().cancel()
            }
        })
        .padding(.top, -8)
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        
        Section() {
            List {
                ForEach(vm.allCoins) { coin in
                    CryptoRowView(coin: coin, showHoldingsColumn: false)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                        .onTapGesture {
                            segue(coin: coin)
                        }
                }
            }
        }
        .listStyle(.plain)
    }
    
    private func segue(coin: CryptoModel) {
        selectedCoin = coin
        showDetailView.toggle()
    }
    
    private var portfolioList: some View {
        
        List {
            ForEach(vm.portfolioCoins) { coin in
                CryptoRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
            
        }
        //.padding(.top, -13)
        .listStyle(.plain)
    }

    private var columnTitles: some View {
        
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1 : 0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            /// original
            /*
            if showPortFolio {
                HStack(spacing: 4) {
                    Text("Holding")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1 : 0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
             */
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1 : 0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .frame(width: (Screen.getScreenBounds()?.bounds.width ?? 0)/3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
                
            
            Button(action: {
                withAnimation(.linear(duration: 2)) {
                    vm.reloadData()
                }
            }, label: {
                Image(systemName: "goforward")
            })
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal, 21)
    }
}
