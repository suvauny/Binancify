//
//  HomeViewModel.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/5/24.
//

import Foundation
import Combine
import SwiftUI

class Home: ObservableObject {
    
    @Published var statistics: [StatModel] = []
    
    @Published var allCoins: [CryptoModel] = []
    @Published var portfolioCoins: [CryptoModel] = []
    @Published var isLoading: Bool = false
    @Published var searchText:String = ""
    @Published var sortOption: SortOption = .rank
    var avatar: String = "avatar"
    
    var showAd: Bool = false
    var alert: AlertModel?
    var adImage:UIImage?
    var adURL:URL?
    
    private let coinDataService = CryptoData()
    private let marketDataService = MarketData()
    private let portfolioDataService = PortfolioData()
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init() {
        addSubscribers()
        getAdData()
        getAlertData()
    }
    
    func addSubscribers() {
        
        // update allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // updates portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCointsToPortfolioCoins)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else {return}
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        // updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)

    }
    
    func getAlertData() {
        AlertService.getAlertData { alert in
            guard let alert = alert else {
                print("Alert is nil")
                return
            }
            self.alert = alert
        }
    }
    
    func getAdData() {
        AdvertisementService.getAdData { adImage, adURL in
            guard let image = adImage, let url = adURL else {
                return
            }
            
            self.adImage = image
            self.adURL = URL(string: url)
            self.showAd = true
        }
    }
    
    func updatePortfolio(coin: CryptoModel, amount:Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    private func filterAndSortCoins(text:String, coins: [CryptoModel], sort: SortOption) -> [CryptoModel] {
        var updatedCoins = filteredCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    private func filteredCoins(text:String, coins: [CryptoModel]) -> [CryptoModel] {
        guard !text.isEmpty else{
            return coins
        }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) || coin.symbol.contains(lowercasedText) || coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private func sortCoins(sort: SortOption, coins: inout [CryptoModel]) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: {$0.rank < $1.rank})
        case .rankReversed, .holdingsReversed:
            coins.sort(by: {$0.rank > $1.rank})
        case .price:
            coins.sort(by: {$0.currentPrice > $1.currentPrice})
        case .priceReversed:
            coins.sort(by: {$0.currentPrice < $1.currentPrice})
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CryptoModel]) -> [CryptoModel] {
        // will only sort by holdings or reversedholdings if needed
        switch sortOption {
        case .holdings:
            return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue})
        case .holdingsReversed:
            return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})
        default:
            return coins
        }
    }
    
    private func mapAllCointsToPortfolioCoins(allCoins: [CryptoModel], portfolioEntities: [PortfolioEntity]) -> [CryptoModel] {
        
        allCoins
            .compactMap { (coin) -> CryptoModel? in
                guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else {
                    return nil
                }
                
                return coin.updateUserHoldings(amount: entity.amount)
            }
        
    }
    
    private func mapGlobalMarketData(marketDataModel:MarketDataModel?, portfolioCoins: [CryptoModel]) -> [StatModel] {
        var stats: [StatModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = StatModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatModel(title: "BTC Dominance", value: data.btcDominance)
        
        
        let portfolioValue = 
            portfolioCoins
                .map({$0.currentHoldingsValue})
                .reduce(0, +)
        
        let previousValue =
            portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        
        
        let portfolio = StatModel(
            ///originial
            //title: "Portfolio Value",
            title: "Watch List Value",
            value: portfolioValue.asCurrencyWith2Decimals(),
            percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        
        return stats
        
    }
}
