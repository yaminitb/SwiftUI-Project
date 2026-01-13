//
//  SplashView.swift
//  MovieApp
//
//  Created by MacMini on 09/01/26.
//

import SwiftUI

struct SplashView: View {
    @State private var showSignup : Bool = false
    @State private var showHome : Bool = false
    var body: some View {
        NavigationStack {
            Login(showSignup: $showSignup,showHome: $showHome)
                .navigationDestination(isPresented: $showSignup) {
                    SignUp(showSignup: $showSignup)
                }
                .navigationDestination(isPresented: $showHome) {
                   // ContentView(showHome: $showHome)
                }
        }
//        .overlay {
//            CircleView()
//                .animation(.smooth(duration: 0.45,extraBounce: 0),value: showSignup)
//        }
       // AddressView()
    }
    @ViewBuilder
    func CircleView() -> some View {
        Circle()
            .fill(.linearGradient(colors: [.appYellow,.orange,.red], startPoint: .top,endPoint: .bottom))
            .frame(width: 200,height: 200)
            .offset(x:showSignup ? 90 : -90,y:-90)
            .blur(radius: 15)
            .hSpacing(showSignup ? .trailing : .leading)
            .vSpacing(.top)
    }
}

#Preview {
    SplashView()
}
