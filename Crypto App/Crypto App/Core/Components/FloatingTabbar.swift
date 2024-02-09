//
//  FloatingTabbar.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/8/24.
//

import SwiftUI

struct FloatingTabbar : View {
     
    @Binding var selected : Int
    @State var expand = false
     
    var body : some View{
         
        HStack{
             
            Spacer(minLength: 0)
             
            HStack{
                if !self.expand{
                     
                    Button(action: {
                        self.expand = true
                        HapticManager.notification(type: .success)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10) {
                            self.expand = false
                        }
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.theme.accent)
                            .padding()
                    }
                }
                else{
                    Button(action: {
                        self.selected = 0
                    }) {
                        VStack {
                            Image(systemName: "chart.pie")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(self.selected == 0 ? Color.theme.accent : .gray)
                                .padding(.horizontal)
                            Text("Market")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundStyle(self.selected == 0 ? Color.theme.accent : .gray)
                        }
                    }
                    Spacer(minLength: 15)
                     
                    Button(action: {
                        self.selected = 1
                    }) {
                        VStack {
                            Image(systemName: "folder")
                                .resizable()
                                .font(.callout)
                                .frame(width: 20, height: 20)
                                .foregroundColor(self.selected == 1 ? Color.theme.accent : .gray)
                                .padding(.horizontal)
                            Text("Portfolio")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundStyle(self.selected == 1 ? Color.theme.accent : .gray)
                        }
                    }
                   Spacer(minLength: 15)
                    
                   Button(action: {
                       self.selected = 2
                   }) {
                       VStack {
                           Image(systemName: "gear")
                               .resizable()
                               .frame(width: 20, height: 20)
                               .foregroundStyle(self.selected == 2 ? Color.theme.accent : .gray)
                               .padding(.horizontal)
                           Text("Settings")
                               .font(.caption)
                               .fontWeight(.bold)
                               .foregroundStyle(self.selected == 2 ? Color.theme.accent : .gray)
                       }
                   }
                }
            }.padding(.vertical,self.expand ? 15 : 8)
            .padding(.horizontal,self.expand ? 35 : 8)
            .background(Color.theme.background)
            .clipShape(Capsule())
            .shadow(color: Color.theme.accent.opacity(0.3), radius: 10)
            .padding(22)
            //.padding(.bottom, -30)
            .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6))
        }
        .offset(y: -20)
        
    }
}

#Preview {
    FloatingTabbar(selected: .constant(0))
}
