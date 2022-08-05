//
//  ImageUploader.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 31.07.2022.
//
import FirebaseStorage
import UIKit

struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
    
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
            print("Dubug: failed to... \(error.localizedDescription)")
            return
        }
        
        ref.downloadURL { imageUrl, _ in
            guard let imageUrl = imageUrl?.absoluteString else { return }
                    completion(imageUrl)
            }
        }
    }
}
