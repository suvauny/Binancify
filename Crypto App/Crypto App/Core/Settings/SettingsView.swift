//
//  SettingsView.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/7/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var vm: Home
    
    @State var showAboutView: Bool = false
    @State var showAdminView: Bool = false
    var admin: String = ""
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    //.clipShape(Circle())
                    //.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding()
                    .padding(.top)
                
                HStack(spacing: 10) {
                    Text("Settings")
                        .font(.title2)
                        .fontWeight(.bold)
                        
                }
                .padding(.bottom, 10)
                Spacer()
                
                List {
                    /*
                    HStack {
                        Image(systemName: "wrongwaysign")
                        Text("Remove Ads")
                            .font(.headline)
                    }
                    //.listRowBackground(Color.red)
                    HStack {
                        Image(systemName: "dollarsign.circle")
                        Text("Restore Purchases")
                            .font(.headline)
                    }
                     */
                    
                    Section("General") {
                        Button(action: {
                            showAboutView = true
                        }, label: {
                            HStack {
                                Image(systemName: "info.circle")
                                Text("About")
                                    .font(.headline)
                            }
                        })
                        .listRowBackground(Color.theme.background)

                        Button(action: {
                            showAdminView = true
                        }, label: {
                            HStack {
                                Image(systemName: "lock")
                                Text("Admin")
                                    .font(.headline)
                            }
                        })
                        .listRowBackground(Color.theme.background)
                    }
                    
                    Section("Policies") {
                        Button(action: {
                            guard let url = URL(string: "https://www.termsfeed.com/live/f7d6c415-f492-444d-afca-1916ee5aeb4d") else { return }
                            UIApplication.shared.open(url)
                        }, label: {
                            HStack {
                                Image(systemName: "lock.shield")
                                Text("Privacy")
                                    .font(.headline)
                            }
                        })
                        .listRowBackground(Color.theme.background)
                        
                        Button(action: {
                            guard let url = URL(string: "https://www.termsfeed.com/live/0c065702-f390-4707-8f02-63bf3f9051dd") else { return }
                            UIApplication.shared.open(url)
                        }, label: {
                            HStack {
                                Image(systemName: "book.pages")
                                Text("Terms of Service")
                                    .font(.headline)
                            }
                        })
                        .listRowBackground(Color.theme.background)
                    }
                }
                .listRowSpacing(10)
                .listStyle(.plain)
            }
            .sheet(isPresented: $showAboutView, content: {
                AboutView()
            })
            .sheet(isPresented: $showAdminView, content: {
                AdminView()
            })
        }
    }
}

#Preview {
    SettingsView()
}

