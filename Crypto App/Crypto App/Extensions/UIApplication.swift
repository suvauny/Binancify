//
//  UIApplication.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/5/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditting() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
