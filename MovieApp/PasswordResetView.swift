//
//  PasswordResetView.swift
//  LoginApp
//
//  Created by MacMini on 09/01/26.
//

import SwiftUI

struct PasswordResetView: View {
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(alignment: .leading,spacing: 15, content: {
            Button(action: {
                dismiss()
            }, label :{
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 10)
            Text("Reset Password")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)
            
            VStack(spacing: 25) {
                CustomTF(sfIcon: "lock", hint: "Password", value: $password)
               
                CustomTF(sfIcon: "lock", hint: "Confirm Password", value: $confirmPassword)
                    .padding(.top,5)

                GradientButton(title: "Send Link", icon: "arrow.right") {
                   
                }.hSpacing(.trailing)
                    .disableWithOpacity(password.isEmpty || confirmPassword.isEmpty)
            }.padding(.top,20)
           
        })
        .padding(.vertical,15)
        .padding(.horizontal,25)
        .interactiveDismissDisabled()
    }
}

#Preview {
    PasswordResetView()
}
