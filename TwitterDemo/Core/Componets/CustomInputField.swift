//
//  CustomInputField.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 27.07.2022.
//

import SwiftUI

struct CustomInputField: View {
    let imageName: String
    let placeholderText: String
    var isSecureTogle: Bool
//    let isSecureFild: Bool? = false
    @State private var isSecureFild = false
    @Binding var text: String
    var body: some View {
        VStack {
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                
                
                if isSecureFild { SecureField(placeholderText, text: $text)
                } else {
                    TextField(placeholderText, text: $text)
                    
                        }
                if isSecureTogle == true {
                    Toggle(isOn: $isSecureFild) {
                        Text("")
                    }.toggleStyle(TugleDisaine())
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .foregroundColor(Color(.systemBlue))
                        .padding(.trailing, 10)
                }
            }
            
            Divider()
                .background(Color(.darkGray))
        }
    }
}

struct TugleDisaine: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Button {
                configuration.isOn.toggle()
            } label: {
                Image(systemName: configuration.isOn ? "eye.slash.fill" : "eye.fill")
                    .resizable()
            }
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(imageName: "envelope", placeholderText: "Email", isSecureTogle: true, text: .constant(""))
        
    }
}
