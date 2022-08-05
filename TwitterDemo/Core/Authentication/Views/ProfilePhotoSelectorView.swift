//
//  ProfilePhotoSelectorView.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 28.07.2022.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack {
            AuthHederView(title1: "Create your account",
                          title2: "Add a profile photo")
            
            Button {
                showImagePicker.toggle()
            } label: {
                VStack {
                    if let profileImage = profileImage {
                        profileImage
                            .resizable()
//                            .renderingMode(.template)
//                            .foregroundColor(Color(.systemBlue))
//                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .padding(.top, 45)
                    } else {
                    
                    Image(systemName: "person.crop.circle.badge.plus")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color(.systemBlue))
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding(.top, 45)
                
                    Text("Add photo")
                        .bold()
                        .frame(width: 200, height: 30)
                        . background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
                    }
                }
            }
            .sheet(isPresented: $showImagePicker,
                   onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage)
            }

            if let selectedImage = selectedImage {
                Button {
                    viewModel.uploadProfileImage(selectedImage)
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                        .padding()
                        .padding(.vertical, 45)
                }
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            }
            Spacer()
        }
        .ignoresSafeArea()
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
        
    }
}

struct ProfilePhotoSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectorView()
    }
}
