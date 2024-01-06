//
//  ContentView.swift
//  PhotosPicker
//
//  Created by dmu mac 27 on 06/01/2024.
//

import SwiftUI
import PhotosUI // import det her


struct ContentView: View {
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $photosPickerItem){
                Text("tryk her")
            }
            
            // vis det valgte billede:
            Image(uiImage: selectedImage ?? UIImage(systemName: "photo")!)
                .resizable()
                .frame(width: 100, height: 100)
        }
        .padding()
        
        
        // kode der sørger for at selected image bliver opdateret
        .onChange(of: photosPickerItem) { _, _ in Task {
            if let photosPickerItem,
               let data = try? await photosPickerItem.loadTransferable(type: Data.self){
                if let image = UIImage(data:data){		
                    selectedImage = image
                }
            }
            photosPickerItem = nil
        }
        }
    }}
                

#Preview {
    ContentView()
}
