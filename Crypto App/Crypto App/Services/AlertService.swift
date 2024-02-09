//
//  AlertService.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/7/24.
//

import Foundation
import Firebase
import FirebaseFirestore

class AlertService {
    
    static let name = "alert"
    static let db = Firestore.firestore().collection("Alert")
    
    static func updateAlertData(title:String, message:String, url:String, completion: @escaping (Bool) -> Void) {
        
        let metadata:[String:String] = ["title":title, "message":message, "url":url]
        
        db.document(name).setData(metadata) { error in
            guard error == nil else {
                print("Error updating alert data: \(error)")
                completion(false)
                return
            }
            print("Success in updating alertData")
            completion(true)
        }
    }
    
    static func getAlertData(completion: @escaping (AlertModel?) -> Void) {
        
        db.document(name).getDocument { snapshot, error in
            guard error == nil && snapshot?.data() != nil else {
                print("Error retrieving alert data: \(error)")
                completion(nil)
                return
            }
            print("Success in getting alert data")
            
            if let data = snapshot?.data() {
                
                let title = data["title"] as? String
                let message = data["message"] as? String
                let url = data["url"] as? String
                
                let alert = AlertModel(title: title ?? "", message: message ?? "", url: url ?? "")
                completion(alert)
            }
        }
    }
    
}
