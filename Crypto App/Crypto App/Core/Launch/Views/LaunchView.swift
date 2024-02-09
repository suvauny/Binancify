//
//  LaunchView.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/8/24.
//

import SwiftUI

struct LaunchView: View {

    @State private var showLoadingText: Bool = false
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    @State private var counter:Int = 0
    @State private var loops:Int = 0
    @Binding var showLaunchView:Bool
    
    
    var body: some View {
        ZStack {
            Color.launch.background
                .ignoresSafeArea()
            
            Image("binanCapLogo1")
                .resizable()
                .frame(width: 100, height: 100)
            ZStack {
                if showLoadingText {
                    HStack {
                        ProgressView()
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 70)
        }
        .onAppear() {
            showLoadingText.toggle()
        }
        .onReceive(timer, perform: { _ in
            showLaunchView = false
            timer.upstream.connect().cancel()
        })
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
}
