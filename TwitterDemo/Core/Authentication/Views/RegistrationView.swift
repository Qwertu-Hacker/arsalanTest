//
//  RegistrationView.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 27.07.2022.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        VStack {
            
            NavigationLink(destination: ProfilePhotoSelectorView(),
                           isActive: $viewModel.didAuthenticateUser,
                           label: { })
            
            AuthHederView(title1: "Get started.", title2: "Create your account")
            
            VStack(spacing: 40) {
                CustomInputField(imageName: "envelope", placeholderText: "Email", isSecureTogle: false, text: $email)
                    
                CustomInputField(imageName: "person", placeholderText: "Username", isSecureTogle: false, text: $username)
                
                CustomInputField(imageName: "person", placeholderText: "Full name", isSecureTogle: false, text: $fullname)
                
                CustomInputField(imageName: "lock", placeholderText: "Password", isSecureTogle: true, text: $password)
                    
            }
            .padding(32)
        
            Button {
                viewModel.register(withEmail: email, password: password, fullname: fullname, username: username)
            } label: {
                Text("Sing In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x:0 , y: 0)
            
            Spacer()
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Text("Alrady have an account?")
                        .font(.footnote)

                    Text("Sing In")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)
            .foregroundColor(Color(.systemBlue))
        }
        .ignoresSafeArea()
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
