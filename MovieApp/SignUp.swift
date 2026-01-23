//
//  SignUp.swift
//  LoginApp
//
//  Created by MacMini on 08/01/26.
//

import SwiftUI

struct SignUp: View {
    @Binding var showSignup : Bool
    @State private var emailId: String = ""
    @State private var password: String = ""
    @State private var fullName: String = ""
    @State private var askOTP: Bool = false
    @State private var otpText: String = ""
    @State private var showBoarding: Bool = false

    var body: some View {
        VStack(alignment: .leading,spacing: 15, content: {
            Button(action: {
                showSignup = false
            }, label :{
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 10)
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 25)
            Text("Please sign up to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            VStack(spacing: 25) {
                CustomTF(sfIcon: "at", hint: "Email ID", value: $emailId)
                    .keyboardType(.emailAddress)

                CustomTF(sfIcon: "person", hint: "Full Name", value: $fullName)
                    .padding(.top, 5)
                CustomTF(sfIcon: "lock", hint: "Password",isPassword: true, value: $password)
                    .padding(.top, 5)
                
                GradientButton(title: "Continue", icon: "arrow.right") {
                    askOTP.toggle()
                    saveData()

                }.hSpacing(.trailing)
                    .disableWithOpacity(emailId.isEmpty || password.isEmpty || fullName.isEmpty)
            }.padding(.top,20)
            Spacer(minLength: 0)
            HStack(spacing: 6) {
                Text("Already have an account?")
                    .foregroundColor(.gray)
                Button("Login") {
                    showSignup = false
                }
                .fontWeight(.bold)
                .tint(.appYellow)
            }
            .font(.callout)
            .hSpacing()
        })
        .padding(.vertical,15)
        .padding(.horizontal,25)
        .toolbar(.hidden,for: .navigationBar)
        .sheet(isPresented: $askOTP) {
            if #available(iOS 16.4, *) {
                OTPView(otpText: $otpText,showBoarding: $showBoarding)
                    .presentationDetents([.height(350)])
                    .presentationCornerRadius(30)
            }else{
                OTPView(otpText: $otpText,showBoarding: $showBoarding)
                    .presentationDetents([.height(350)])
            }
        }
        .sheet(isPresented: $showBoarding) {
            if #available(iOS 16.4, *) {
                OnboardingView()
                  //  .presentationDetents([.height(350)])
                    .presentationCornerRadius(30)
            }else{
                OnboardingView()
                  //  .presentationDetents([.height(350)])
            }
        }
    }
    func saveData()
    {
        UserDefaults.standard.set(self.emailId, forKey: "email")
        UserDefaults.standard.set(self.password, forKey: "password")
        UserDefaults.standard.set(self.fullName, forKey: "name")

    }
}

#Preview {
    SplashView()
}
