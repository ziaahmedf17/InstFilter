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
    @State private var filterIntensity = 0.5
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    Rectangle()
                        .fill(.secondary)
                    Text("Tap to select a picture")
                        .foregroundStyle(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                HStack{
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) {
                            applyProcessing()
                        }
                }
                .padding(.vertical)
                
                HStack{
                    Button("Change Filter"){
                        showingFilterSheet = true
                    }
                    Spacer()
                    
                    Button("Save", action: save)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("InsFilter")
            .onChange(of: inputImage) {
                loadImage()
            }
            .sheet(isPresented: $showingImagePicker){
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select Filter", isPresented: $showingFilterSheet){
                Button("Crystalize"){ setFilter(CIFilter.crystallize())}
                Button("Edges"){ setFilter(CIFilter.edges())}
                Button("Gausian Blur"){ setFilter(CIFilter.gaussianBlur())}
                Button("Pixellat"){ setFilter(CIFilter.pixellate())}
                Button("Sepia Tone"){ setFilter(CIFilter.sepiaTone())}
                Button("Unsharp Mask"){ setFilter(CIFilter.unsharpMask())}
                Button("Vignette"){ setFilter(CIFilter.vignette())}
                Button("Cancel", role: .cancel){}
            }
        }
    }
    
    func loadImage()
    {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func save()
    {
        guard let processedImage = processedImage else { return }
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success")
        }
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        
        imageSaver.WriteToPhotoAlbum(image: processedImage)
    }
    
    func applyProcessing()
    {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey){
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey){
            currentFilter.setValue(filterIntensity*200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey){
            currentFilter.setValue(filterIntensity*10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filer: CIFilter)
    {
        currentFilter = filer
        loadImage()
    }
}

#Preview {
    ContentView()
}
