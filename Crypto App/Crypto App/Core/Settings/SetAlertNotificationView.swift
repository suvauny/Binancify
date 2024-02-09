//
//  SetAlertNotificationView.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/8/24.
//

import SwiftUI

struct SetAlertNotificationView: View {
    
    @State var titleText:String = ""
    @State var messageText:String = ""
    @State var urlString:String = ""
    @State var showAlert: Bool = false
    @State var showProgress:Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                headerTitle
                titleTextField
                messageTextField
                urlTextField
                if showProgress {
                    ProgressView()
                }
                setAlertButton
                Spacer()
            }
        }
    }
}

#Preview {
    SetAlertNotificationView()
}


extension SetAlertNotificationView {
    
    private var headerTitle: some View {
        HStack(spacing: 0) {
            Image(systemName: "bell.badge")
            Text("Set Alert Notification")
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
        }
        .padding()
    }
    
    private var titleTextField: some View {
        HStack {
            Image(systemName: "")
            TextField("Title", text: $titleText)
                .foregroundStyle(Color.theme.accent)
                .autocorrectionDisabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(titleText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.endEditting()
                            titleText = ""
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
    
    private var messageTextField: some View {
        HStack {
            Image(systemName: "")
            TextField("Message", text: $messageText)
                .foregroundStyle(Color.theme.accent)
                .autocorrectionDisabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(messageText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.endEditting()
                            messageText = ""
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
    
    private var urlTextField: some View {
        HStack {
            Image(systemName: "")
            TextField("URL", text: $urlString)
                .foregroundStyle(Color.theme.accent)
                .autocorrectionDisabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(urlString.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.endEditting()
                            urlString = ""
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
    
    private var setAlertButton: some View {
        
        Button(action: {
            if titleText != "", messageText != "", urlString != "" {
                showProgress = true
                AlertService.updateAlertData(title: titleText, message: messageText, url: urlString) {didSetAlert in
                    if didSetAlert {
                        showAlert = true
                    }
                }
            }
        }, label: {
            HStack(spacing:10) {
          
                Image(systemName: "square.and.arrow.up")
                Text("Set Alert")
                    .font(.callout)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
       
            }
        })
        .alert(isPresented: $showAlert) { () -> Alert in
            showAlert = false
            let primary = Alert.Button.default(Text("Ok")) {
                titleText = ""
                 messageText = ""
                 urlString = ""
            }
            return Alert(title: Text("Success"), message: Text("Alert was updated successfully."), dismissButton: primary)
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
