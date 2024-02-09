//
//  XMarkbutton.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/7/24.
//

import SwiftUI

struct XButton: View {
    
    @Environment(\.dismiss) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.callAsFunction()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

#Preview {
    XButton()
}
