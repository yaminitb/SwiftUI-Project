//
//  Login.swift
//  LoginApp
//
//  Created by MacMini on 07/01/26.
//

import SwiftUI

struct Login: View {
    @Binding var showSignup : Bool
    @Binding var showHome : Bool

    @State private var emailId: String = ""
    @State private var password: String = ""
    @State private var showForgotPasswordView: Bool = false
    @State private var showResetView: Bool = false
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        VStack(alignment: .leading,spacing: 15, content: {
            Spacer(minLength: 0)
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.heavy)
            Text("Please sign in to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            VStack(spacing: 25) {
                CustomTF(sfIcon: "at", hint: "Email ID", value: $emailId)
                CustomTF(sfIcon: "lock", hint: "Password",isPassword: true, value: $password)
                    .padding(.top, 5)
                
                Button("Forgot Password") {
                    showForgotPasswordView.toggle()
                }.font(.callout)
                    .fontWeight(.heavy)
                    .tint(.appYellow)
                    .hSpacing(.trailing)
                GradientButton(title: "Login", icon: "arrow.right") {
                    showHome.toggle()
                    authManager.login()
                }
                
                .hSpacing(.trailing)
                    .disableWithOpacity(emailId.isEmpty || password.isEmpty)
            }.padding(.top,20)
            Spacer(minLength: 0)
            HStack(spacing: 6) {
                Text("Don't have an account?")
                    .foregroundColor(.gray)
                Button("SignUp") {
                    showSignup.toggle()
                }
                .fontWeight(.bold)
                .tint(.appYellow)
            }
            .font(.callout)
            .hSpacing()
        })
        .padding(.vertical,15)
        .padding(.horizontal,25)
      //  .toolbar(.hidden,for: .navigationBar)
        .sheet(isPresented: $showForgotPasswordView) {
            if #available(iOS 16.4, *) {
                ForgotPassword(showResetView: $showResetView)
                    .presentationDetents([.height(300)])
                    .presentationCornerRadius(30)
            }else{
                ForgotPassword(showResetView: $showResetView)
                    .presentationDetents([.height(300)])
            }
        }
        .sheet(isPresented: $showResetView) {
            if #available(iOS 16.4, *) {
                PasswordResetView()
                    .presentationDetents([.height(350)])
                    .presentationCornerRadius(30)
            }else{
                PasswordResetView()
                    .presentationDetents([.height(350)])
            }
        }
    }
}

#Preview {
    SplashView()
}
