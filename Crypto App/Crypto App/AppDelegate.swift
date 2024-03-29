//
//  AppDelegate.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/7/24.
//

import Foundation
import UIKit
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
