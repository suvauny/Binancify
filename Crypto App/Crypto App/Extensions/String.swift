//
//  String.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/7/24.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
