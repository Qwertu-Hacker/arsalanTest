//
//  LoginView.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 27.07.2022.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
//    @State private var isSecureFild = true
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        VStack {
             
            
            AuthHederView(title1: "Hello.", title2: "Wellcome Back") 
            VStack(spacing: 40) {
                CustomInputField(imageName: "envelope", placeholderText: "Email", isSecureTogle: false, text: $email)
                
                CustomInputField(imageName: "lock",                         placeholderText: "Password",               isSecureTogle: true,
                                 text: $password)
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            HStack {
                Spacer()
                
                NavigationLink {
                    Text("Reset passwodr view..")
                } label: {
                    Text("Forgot Password?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                        .padding(.top)
                        .padding(.trailing, 24)
                    }
                }
            
            Button {
                viewModel.login(withEmail: email, password: password)
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
            
            NavigationLink(destination: RegistrationView()) {
                HStack {
                    Text("Don't have an account?")
                        .font(.footnote)

                    Text("Sing up.")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)
            .foregroundColor(Color(.systemBlue))
            
        }
        .ignoresSafeArea()
//        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
