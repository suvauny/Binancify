//
//  SetAdvertisementView.swift
//  Crypto App
//
//  Created by Suvauny Campbell on 2/8/24.
//

import SwiftUI
import PhotosUI

struct SetAdvertisementView: View {
    
    @State var urlString:String = ""
    @State var selectedImage:[PhotosPickerItem] = []
    @State var finalImage: UIImage?
    
    @State var showAlert:Bool = false
    @State var showAlert2:Bool = false
    @State var showProgress:Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                headerTitle
                urlTextField
                photoPicker
                displayImage
                if showProgress {
                    ProgressView()
                }
                HStack {
                    setAdButton
                    deleteAdButton
                }
                Spacer()
            }
        }
    }
}

#Preview {
    SetAdvertisementView()
}

extension SetAdvertisementView {
    private var headerTitle: some View {
        HStack(spacing: 0) {
            Image(systemName: "photo.circle")
            Text("Set Advertisement")
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
        }
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
    
    private var photoPicker: some View {
        PhotosPicker(
            selection: $selectedImage,
            maxSelectionCount: 1,
            matching: .images
        ) {
            HStack {
                Image(systemName: "plus")
                Text("Add Image")
                    .font(.title3)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
        }
        .onChange(of: selectedImage) { _ ,newValue in
            guard let item = selectedImage.first else {
                return
            }
            item.loadTransferable(type: Data.self) { result in
                
                switch result {
                case .success(let data):
                    if let data = data {
                        withAnimation(.easeIn) {
                            self.finalImage = UIImage(data: data)
                        }
                    }
                    else {
                        print("Data is nil")
                    }
                case .failure(let failure):
                    print("\(failure)")
                }
            }
        }
    }
    
    private var displayImage: some View {
        Image(uiImage: finalImage ?? UIImage(named: "ad")!)
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .frame(maxWidth: .infinity, maxHeight: 200)
            .shadow(color: Color.theme.accent.opacity(0.2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .padding()
            .opacity(finalImage == nil ? 0.3 : 1)
    }
    
    private var setAdButton: some View {
        Button(action: {
            
            guard finalImage != nil, urlString != "" else {
                return
            }
            showProgress = true
            
            AdvertisementService.uploadAdImageAndUrl(adImage: self.finalImage ?? UIImage(), url: urlString) { didSetData in
                
                if didSetData {
                    showAlert = true
                }
            }
        }, label: {
            HStack(spacing:10) {
          
                Image(systemName: "square.and.arrow.up")
                Text("Set Ad")
                    .font(.callout)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
        })
        .alert(isPresented: $showAlert) { () -> Alert in
            
            let primary = Alert.Button.default(Text("Ok")) {
                        urlString = ""
                        finalImage = nil
                        showProgress = false
                    }
            return Alert(title: Text("Success"), message: Text("Advertisement was updated successfully."), dismissButton: primary)
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
    
    private var deleteAdButton: some View {
        
        Button(action: {
            showProgress = true
            AdvertisementService.removeCurrentAd { didRemove in
                if didRemove {
                    showAlert2 = true
                }
            }
        }, label: {
            HStack(spacing:10) {
          
                Image(systemName: "trash")
                Text("Delete Ad")
                    .font(.callout)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
        })
        .alert(isPresented: $showAlert2) { () -> Alert in
            let primary = Alert.Button.default(Text("Ok")) {
                showProgress = false
            }
            return Alert(title: Text("Deleted"), message: Text("Current advertisement was deleted successfully."), dismissButton: primary)
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
