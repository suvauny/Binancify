//
//  MarketDataModel.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/5/24.
//

import Foundation

//JSON Data
/*
 URL: https://api.coingecko.com/api/v3/global
 
 
 JSON Response:
 
 {
   "data": {
     "active_cryptocurrencies": 12586,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 929,
     "total_market_cap": {
       "btc": 40300547.157536566,
       "eth": 747100521.5948992,
       "ltc": 25361918354.089268,
       "bch": 7272436278.380289,
       "bnb": 5686523955.63341,
       "eos": 2426521887621.036,
       "xrp": 3368184818232.673,
       "xlm": 15776703650442.834,
       "link": 89934014055.43364,
       "dot": 254846004880.0689,
       "yfi": 243322816.94557887,
       "usd": 1706812645047.1816,
       "aed": 6269122845258.29,
       "ars": 1415001819427591.8,
       "aud": 2632543446592.003,
       "bdt": 187543320637303.03,
       "bhd": 643401801489.6316,
       "bmd": 1706812645047.1816,
       "brl": 8509485123147.222,
       "cad": 2311215484410.13,
       "chf": 1486268555930.058,
       "clp": 1628725966536274.8,
       "cny": 12151652626413.43,
       "czk": 39680320027773.26,
       "dkk": 11852630998689.668,
       "eur": 1589022090787.188,
       "gbp": 1361572237708.1975,
       "gel": 4548655699050.754,
       "hkd": 13349778778419.252,
       "huf": 614347349405984.2,
       "idr": 26875092479341496,
       "ils": 6267544043561.636,
       "inr": 141738939770974.2,
       "jpy": 253766533490600.56,
       "krw": 2277128176068596.5,
       "kwd": 525314261829.3984,
       "lkr": 534354203840874.06,
       "mmk": 3588527404981965,
       "mxn": 29221825545246.676,
       "myr": 8107872107767.633,
       "ngn": 1544665443767702.5,
       "nok": 18252995788663.6,
       "nzd": 2818724276726.3936,
       "php": 96178890841596.22,
       "pkr": 473332917466577.5,
       "pln": 6897863126126.974,
       "rub": 154602594412706.88,
       "sar": 6400905849582.395,
       "sek": 18090645476679.332,
       "sgd": 2299378738716.731,
       "thb": 61058662157595.516,
       "try": 52138860981391.36,
       "twd": 53592210241836.414,
       "uah": 64143790872398.586,
       "vef": 170903150148.57437,
       "vnd": 41619435528481496,
       "zar": 32548217347865.316,
       "xdr": 1281425436334.7192,
       "xag": 76341855148.2564,
       "xau": 842858220.3772,
       "bits": 40300547157536.56,
       "sats": 4030054715753656.5
     },
     "total_volume": {
       "btc": 1230712.7058995764,
       "eth": 22815226.327245902,
       "ltc": 774511448.7491066,
       "bch": 222088293.13559005,
       "bnb": 173657128.20828485,
       "eos": 74102004287.05988,
       "xrp": 102858847931.09572,
       "xlm": 481794690377.57587,
       "link": 2746437495.200969,
       "dot": 7782579601.89983,
       "yfi": 7430680.315073561,
       "usd": 52123262759.642204,
       "aed": 191448744116.1656,
       "ars": 43211838073391.67,
       "aud": 80393565275.64043,
       "bdt": 5727265853554.625,
       "bhd": 19648437253.137512,
       "bmd": 52123262759.642204,
       "brl": 259865738814.47195,
       "cad": 70580735581.98465,
       "chf": 45388207485.417885,
       "clp": 49738623488388.625,
       "cny": 371091569217.27325,
       "czk": 1211771985165.4517,
       "dkk": 361959938444.6229,
       "eur": 48526132150.07385,
       "gbp": 41580186154.72384,
       "gel": 138908495254.44693,
       "hkd": 407680379606.87067,
       "huf": 18761161871924.527,
       "idr": 820721308255645,
       "ils": 191400530098.11334,
       "inr": 4328475080374.954,
       "jpy": 7749614313625.193,
       "krw": 69539765013474.72,
       "kwd": 16042237195.848942,
       "lkr": 16318302219249.943,
       "mmk": 109587749653027.33,
       "mxn": 892386692605.7446,
       "myr": 247601135087.12854,
       "ngn": 47171552797476.29,
       "nok": 557416596604.1666,
       "nzd": 86079222900.72493,
       "php": 2937145804382.581,
       "pkr": 14454812074125.719,
       "pln": 210649442542.198,
       "rub": 4721310025022.197,
       "sar": 195473181233.83792,
       "sek": 552458683973.7314,
       "sgd": 70219260754.74663,
       "thb": 1864631540332.0654,
       "try": 1592235421273.431,
       "twd": 1636618327390.0044,
       "uah": 1958846318454.0967,
       "vef": 5219102300.122976,
       "vnd": 1270989396671045.8,
       "zar": 993969250288.6464,
       "xdr": 39132634105.31939,
       "xag": 2331355223.4323378,
       "xau": 25739509.61596654,
       "bits": 1230712705899.5764,
       "sats": 123071270589957.64
     },
     "market_cap_percentage": {
       "btc": 48.682622341014955,
       "eth": 16.086504336864447,
       "usdt": 5.629411266750562,
       "bnb": 2.704563375122192,
       "sol": 2.433965748488208,
       "xrp": 1.6170040261786403,
       "usdc": 1.5839024522872793,
       "steth": 1.2710936974716196,
       "ada": 1.0085261089571342,
       "avax": 0.7370556466116708
     },
     "market_cap_change_percentage_24h_usd": -0.5028948377194978,
     "updated_at": 1707169933
   }
 }
 
*/


struct GlobalData: Codable {
    let data: MarketDataModel?
}


struct MarketDataModel: Codable {

    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance:String {
        
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}) {
            return item.value.asPercentString()
        }
        return ""
    }
}
