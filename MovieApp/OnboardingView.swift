//
//  OnboardingView.swift
//  MovieApp
//
//  Created by MacMini on 20/01/26.
//

import SwiftUI
enum OnboardingPage: Int, CaseIterable {
    case unlimited
    case download
    case cancel
    case watch
    
    var title: String{
        switch self {
        case .unlimited:
            return "Unlimited entertainment, one low price"
        case .download:
            return "Download and watch offline"
        case .cancel:
            return "Cancel online anytime"
        case .watch:
            return "Watch Everywhere"
        }
    }
    var description: String{
        switch self {
        case .unlimited:
            return "Everything on Our App, starting at just $9.99/month"
        case .download:
            return "Always have something to watch"
        case .cancel:
            return "Join today, no reason to wait"
        case .watch:
            return "Stream on your phone, tablet, laptop, TV and more"
        }
    }
}
struct OnboardingView: View {
    
    
    @State private var currentPage = 0
    @State private var isAnimating = false
    @State private var deliveryOffset = false
    @State private var trackingProgress: CGFloat = 0.0
    @EnvironmentObject var authManager: AuthManager
    @Environment(\.dismiss) private var dismiss

    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(OnboardingPage.allCases, id: \.rawValue) { page in
                    getPageView(for: page)
                        .tag(page.rawValue)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.spring(),value: currentPage)
            
            HStack(spacing: 12) {
                ForEach(0..<OnboardingPage.allCases.count,id: \.self){ index in
                    Circle()
                        .fill(currentPage == index ? Color.blue : Color.gray.opacity(0.5))
                        .frame(width: currentPage == index ? 12 : 8, height: currentPage == index ? 12 : 8)
                        .animation(.spring(), value: currentPage)
                }
            }
            Button {
                withAnimation(.spring()) {
                    if currentPage < OnboardingPage.allCases.count - 1 {
                        currentPage += 1
                        isAnimating = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                            isAnimating = true
                        })
                    }else {
                        // handle finish
                        dismiss()
                        authManager.login()
                    

                    }
                }
            }label: {
                Text(currentPage < OnboardingPage.allCases.count - 1 ? "Next" : "Get Started")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background {
                        LinearGradient(gradient: Gradient(colors: [Color.blue,Color.blue.opacity(0.8)]), startPoint: .leading, endPoint: .trailing)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.blue.opacity(0.3), radius: 10,x: 0,y: 5)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    isAnimating = true
                }
            }
        }
    }
    private var imagesGroup2: some View {
        ZStack {
//            Circle()
//                .stroke(Color.blue.opacity(0.2), lineWidth: 2)
//                .frame(width: 250, height: 250)
//                .scaleEffect(isAnimating ? 1.1 : 0.9)
//                .animation(.easeInOut(duration: 1.5).repeatForever(), value: isAnimating)
            Image("watching")
                .resizable()
                .scaledToFit()
                .frame(height: 300)
            
        }
        
    }
    private var imagesGroup3: some View {
        ZStack {
            //            Circle()
            //                .stroke(Color.blue.opacity(0.2), lineWidth: 2)
            //                .frame(width: 250, height: 250)
            //                .scaleEffect(isAnimating ? 1.1 : 0.9)
            //                .animation(.easeInOut(duration: 1.5).repeatForever(), value: isAnimating)
            Image("cancelled")
                .resizable()
                .scaledToFit()
                .frame(height: 300)
            
        }
    }
    private var imagesGroup4: some View {
        ZStack {
            //            Circle()
            //                .stroke(Color.blue.opacity(0.2), lineWidth: 2)
            //                .frame(width: 250, height: 250)
            //                .scaleEffect(isAnimating ? 1.1 : 0.9)
            //                .animation(.easeInOut(duration: 1.5).repeatForever(), value: isAnimating)
            Image("tv")
                .resizable()
                .scaledToFit()
                .frame(height: 300)
            
        }
    }
    private var imagesGroup: some View {
        ZStack {
            Image("1")
                .resizable()
                .scaledToFit()
                .frame(height: 240)
                .offset(y: isAnimating ? 0 : 20)
                .animation(.spring(dampingFraction: 0.6).delay(0.2), value: isAnimating)
                .zIndex(1)
            Image("2")
                .resizable()
                .scaledToFit()
                .frame(height: 210)
                .offset(x: -120, y: isAnimating ? 0 : 40)
                .animation(.spring(dampingFraction: 0.6).delay(0.2), value: isAnimating)
            Image("2")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .scaleEffect(x: -1, y: 1)
                .offset(x: 120, y: isAnimating ? 0 : 40)
                .animation(.spring(dampingFraction: 0.6).delay(0.4), value: isAnimating)
        }
    }
    @ViewBuilder
    private func getPageView(for page: OnboardingPage) -> some View {
        VStack(spacing: 30) {
            ZStack {
                switch page {
                case .unlimited:
                    imagesGroup
                case .download:
                    imagesGroup2
                case .cancel:
                    imagesGroup3
                case .watch:
                    imagesGroup4
                default:
                    EmptyView()
                }
            }
            VStack(spacing: 20) {
                
                
                Text(page.title)
                
                    .font(.system(.largeTitle,design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    .animation(.spring(dampingFraction: 0.8).delay(0.3),value: isAnimating)
                Text(page.description)
                    .font(.system(.title3,design: .rounded))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    .animation(.spring(dampingFraction: 0.8).delay(0.3),value: isAnimating)
            }
        }
        .padding(.top, 50)
    }
}

#Preview {
    OnboardingView()
}
