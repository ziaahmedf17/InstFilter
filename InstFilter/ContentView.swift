//
//  ContentView.swift
//  InstFilter
//
//  Created by Zi on 30/07/2025.
//
import CoreImage
import CoreImage.CIFilterBuiltins

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack{
            image?
                .resizable()
                .scaledToFit()
            Button("Select Image"){
                showingImagePicker = true
            }
            Button("Save Image"){
                guard let inputImage = inputImage else {
                    return
                }
                let imageSaver = ImageSaver()
                imageSaver.WriteToPhotoAlbum(image: inputImage)
            }
        }
        .sheet(isPresented: $showingImagePicker){
            ImagePicker(image: $inputImage)
        }
        
        .onChange(of: inputImage){ _ in loadImage()
            
        }
    }
    
    func loadImage()
    {
        guard let inputImage = inputImage else {
            return
        }
        image = Image(UIImage, inputImage)
    }
}

#Preview {
    ContentView()
}
