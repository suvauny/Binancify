//
//  Crypto_AppApp.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/4/24.
//

import SwiftUI

@main
struct Crypto_AppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @State var current = 0
    @StateObject private var vm = Home()
    @State private var showLaunchView:Bool = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                VStack {
                    NavigationStack {
                        
                        if self.current == 0 {
                            HomeView()
                        }
                        else if self.current == 1 {
                            PortfolioView1()
                        }
                        else {
                            SettingsView()
                        }
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                    .environmentObject(vm)
                    //.padding(.bottom, 50)
                }
                VStack {
                    Spacer()
                    Image("bottomGradient")
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundStyle(Color(UIColor.systemBackground))
                }
                .ignoresSafeArea()
                .disabled(true)
                
                VStack {
                    Spacer()
                    FloatingTabbar(selected: $current)
                        .padding(.bottom, -30)
                }
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
