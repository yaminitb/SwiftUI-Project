//
//  OTPView.swift
//  LoginApp
//
//  Created by MacMini on 09/01/26.
//

import SwiftUI

struct OTPView: View {
    @Binding var otpText : String
    @Binding var showBoarding : Bool

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading,spacing: 15, content: {
            Button(action: {
                dismiss()
            }, label :{
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 15)
            Text("Enter OTP")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)
            Text("An 6 digit code has been sent to your Email ID.")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            VStack(spacing: 25) {
               
                OTPVerificationView(otpText: $otpText)
                GradientButton(title: "Submit", icon: "arrow.right") {
                    dismiss()
                    showBoarding = true
                    
                }.hSpacing(.trailing)
                    .disableWithOpacity(otpText.isEmpty)
            }.padding(.top,20)
                Spacer(minLength: 0)
           
        })
        .padding(.vertical,15)
        .padding(.horizontal,25)
        .interactiveDismissDisabled()
    }
}

#Preview {
    SplashView()
}
