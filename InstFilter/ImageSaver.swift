//
//  ImageSaver.swift
//  InstFilter
//
//  Created by Zi on 31/07/2025.
//

import UIKit

class ImageSaver: NSObject{
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func WriteToPhotoAlbum(image: UIImage){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        if let error = error{
            errorHandler?(error)
        }else{
            successHandler?()
        }
    }
}
