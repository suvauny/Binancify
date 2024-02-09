//
//  DetailViewModel.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/7/24.
//

import Foundation
import Combine

class Detail: ObservableObject {
    
    @Published var overviewStatistics: [StatModel] = []
    @Published var additionalStatistics: [StatModel] = []
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil
    
    @Published var coin: CryptoModel
    private let coinDetailService: CryptoDetailData
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CryptoModel) {
        self.coin = coin
        self.coinDetailService = CryptoDetailData(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] (returnedArrays) in
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellables)
        
        coinDetailService.$coinDetails
            .sink { [weak self](returnedCoinDetails) in
                self?.coinDescription = returnedCoinDetails?.readableDescription
                self?.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStatistics(coinDetailModel: CoinDetailModel?, coinModel: CryptoModel) -> (overview: [StatModel], additional: [StatModel]) {
        
        let overviewArray = createOverviewArray(coinModel: coinModel)
        let additionalArray = createAdditionalArray(coinDetailModel: coinDetailModel, coinModel: coinModel)
        
        
        
        
        return (overviewArray,additionalArray)
    }
    
    private func createOverviewArray(coinModel: CryptoModel) -> [StatModel] {
        
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StatModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatModel(title: "Volume", value: volume)
        
        let overviewArray: [StatModel] = [
            priceStat, marketCapStat, rankStat, volumeStat
        ]
        
        return overviewArray
    }
    
    private func createAdditionalArray(coinDetailModel: CoinDetailModel?, coinModel: CryptoModel) -> [StatModel] {
        // additional
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = StatModel(title: "24H High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = StatModel(title: "24H Low", value: low)
        
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceChangeStat = StatModel(title: "24H Price Change", value: priceChange, percentageChange: pricePercentChange)
        
        let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatModel(title: "24H Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? ""
        let hashingStat = StatModel(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray: [StatModel] = [
            highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
        ]
        
        return additionalArray
    }
    
}
