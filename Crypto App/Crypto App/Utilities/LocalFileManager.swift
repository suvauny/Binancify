//
//  LocalFileManager.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/5/24.
//

import Foundation
import SwiftUI


class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    private init() {}
    
    func saveImage(image: UIImage, imageName:String, folderName:String) {
        
        // create folder
        createFolderIfNeeded(folderName: folderName)
         
        // get path for image
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
            else {return}
        
        // save image to  path
        do {
            try data.write(to: url)
        }
        catch let error{
            print("Error saving image: ImageName: \(imageName), \(error)")
        }
    }
    
    func getimage(imageName:String, folderName:String) -> UIImage? {
        
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
        FileManager.default.fileExists(atPath: url.path(percentEncoded: true)) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path(percentEncoded: true))
    }
    
    private func createFolderIfNeeded(folderName:String) {
        
        guard let url = getURLForFolder(folderName: folderName) else {return}
        if !FileManager.default.fileExists(atPath: url.path(percentEncoded: true)) {
            do {
                try FileManager.default.createDirectory(atPath: url.path(percentEncoded: true), withIntermediateDirectories: true, attributes: nil)
            }
            catch let error{
                print("Error creating directory: Foldername: \(folderName), \(error)")
            }
        }
        
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName, conformingTo: .folder)
    }
    
    private func getURLForImage(imageName:String, folderName:String) -> URL? {
        
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png", conformingTo: .fileURL)
    }
}
