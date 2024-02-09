//
//  AdvertisementService.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/9/24.
//

import Foundation
import Firebase
import FirebaseStorage
import SwiftUI


class AdvertisementService {
    
    static let db = Firestore.firestore().collection("Ad").document("ad")
    static let ref = Storage.storage().reference(withPath: "ad")
    
    static func uploadAdImageAndUrl(adImage: UIImage?, url: String, completion: @escaping (Bool) -> Void) {
        guard let data = adImage?.jpegData(compressionQuality: 0.25) else { return }
        
        ref.putData(data) { _, error in
            guard error == nil else {
                completion(false)
                return
            }
            ref.downloadURL { url, error in
                guard error == nil, url != nil else {
                    return
                }
                
                updateURL(url: url?.absoluteString ?? "") { didComplete in
                    if didComplete {
                        completion(true)
                    }
                    else {
                        completion(false)
                    }
                }
            }
        }
    }
    
    static func updateURL(url:String, completion: @escaping (Bool) -> Void) {
        db.setData(["url" : url]) { error in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    static func getAdData(completion: @escaping (UIImage?, String?) -> Void) {
        
        ref.getData(maxSize: 4096 * 4096) { data, error in
            guard error == nil, let data = data else {
                completion(nil, nil)
                return
            }
            
            let image = UIImage(data: data)
            
            db.getDocument { snapshot, error in
                guard error == nil, let data = snapshot else {
                    completion(image, nil)
                    return
                }
                
                completion(image, data["url"] as? String)
            }
        }
        
    }
    
    static func removeCurrentAd(completion: @escaping (Bool) -> Void) {
        db.delete { error in
            if error == nil {
                completion(true)
            }
            else {
                completion(false)
            }
        }
    }
}
