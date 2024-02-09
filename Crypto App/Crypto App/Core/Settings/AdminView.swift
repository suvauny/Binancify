//
//  AdminView.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/8/24.
//

import SwiftUI

struct AdminView: View {
    @State var showAlertNotificationView: Bool = false
    @State var showAdvertisementView:Bool = false
    @State var passwordText: String = ""
    var body: some View {
        
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                
                HStack(spacing:0) {
                    Image(systemName: "lock")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .fontWeight(.semibold)
                    
                    Text("Admin")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding()
                }
                .padding()
                passwordTextField

                List {
                    //
                    if passwordText == "37825" {
                        Button(action: {
                            showAlertNotificationView = true
                        }, label: {
                            HStack {
                                Image(systemName: "bell.badge.fill")
                                Text("Set Notification")
                                    .font(.headline)
                            }
                        })
                        
                        Button(action: {
                            showAdvertisementView = true
                        }, label: {
                            HStack {
                                Image(systemName: "photo.circle")
                                Text("Set Advertisement")
                                    .font(.headline)
                            }
                        })
                    }
                }
                .listRowSpacing(10)
                .listStyle(.plain)
            }
            .sheet(isPresented: $showAlertNotificationView, content: {
                SetAlertNotificationView()
            })
            .sheet(isPresented: $showAdvertisementView, content: {
                SetAdvertisementView()
            })
        }
    }
}

#Preview {
    AdminView()
}


extension AdminView {
    
    private var passwordTextField: some View {
        HStack {
            Image(systemName: "")
            TextField("Password", text: $passwordText)
                .foregroundStyle(Color.theme.accent)
                .autocorrectionDisabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(passwordText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.endEditting()
                            passwordText = ""
                        }
                ,alignment: .trailing)
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.1),
                        radius: 10)
        )
        .padding()
    }
}
