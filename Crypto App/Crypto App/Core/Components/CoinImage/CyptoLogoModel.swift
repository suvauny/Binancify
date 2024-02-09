//
//  CoinImageViewModel.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/5/24.
//

import Foundation
import SwiftUI
import Combine

class CyptoLogoModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    
    private let coin: CryptoModel
    private let dataService: CryptoLogoService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin:CryptoModel) {
        self.coin = coin
        self.dataService = CryptoLogoService(coin: coin)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        
        dataService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellables)

        
    }
}
