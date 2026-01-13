//
//  GradientButton.swift
//  LoginApp
//
//  Created by MacMini on 07/01/26.
//

import SwiftUI

struct GradientButton: View {
    var title: String
    var icon: String
    var onClick: () -> ()
    var body: some View {
        Button(action: onClick) {
            HStack(spacing: 15) {
                Text(title)
                Image(systemName: icon)
            }
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 35)
            .background(.linearGradient(colors: [.appYellow,.orange,.red], startPoint: .top,endPoint: .bottom),in: .capsule)
            
        }
    }
}

#Preview {
    SplashView()
}
