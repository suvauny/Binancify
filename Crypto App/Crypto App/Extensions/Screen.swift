//
//  ScreenBounds.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/5/24.
//

import Foundation
import SwiftUI

struct Screen {
    
    static func getScreenBounds() -> UIScreen? {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let screen = windowScene?.windows.first?.screen
        return screen
    }
}
