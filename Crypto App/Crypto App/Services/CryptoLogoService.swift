//
//  CoinImageService.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/5/24.
//

import Foundation
import SwiftUI
import Combine

class CryptoLogoService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coin: CryptoModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName:String
    
    init(coin:CryptoModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
       
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getimage(imageName: imageName, folderName: folderName) {
            image = savedImage
        } else {
            downloadCoinImage()
        }
        
    }
    
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else {return}
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion , receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloadedImage = returnedImage else{return}
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
