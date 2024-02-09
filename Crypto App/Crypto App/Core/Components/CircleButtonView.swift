//
//  CircleButtonView.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/5/24.
//

import SwiftUI

struct CircleButtonView: View {
    
    @EnvironmentObject private var vm: Home
    
    let iconName:String
    let profileImage:Bool
    
    var body: some View {
        
        if profileImage {
            /// modified
            Image(systemName: iconName)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .frame(width:50, height: 50)
                .background(
                    Circle()
                        .foregroundStyle(Color.theme.background)
                )
                .shadow(color: Color.theme.accent.opacity(0.25),
                        radius: 10)
                .padding()
            /// original
            /*
            Image(vm.avatar)
                .resizable()
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .aspectRatio(contentMode: .fill)
                .frame(width:50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .background(
                    Circle()
                        .foregroundStyle(Color.theme.background)
                )
                .shadow(color: Color.theme.accent.opacity(0.25),
                        radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .padding()
             */
        }
        else {
            Image(systemName: iconName)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .frame(width:50, height: 50)
                .background(
                    Circle()
                        .foregroundStyle(Color.theme.background)
                )
                .shadow(color: Color.theme.accent.opacity(0.25),
                        radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .padding()
        }
    }
}

#Preview {
    
    CircleButtonView(iconName: "info", profileImage: false)
        .previewLayout(.sizeThatFits)
}
