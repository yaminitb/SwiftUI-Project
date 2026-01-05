//
//  UpcomingView.swift
//  MovieApp
//
//  Created by MacMini on 20/12/25.
//

import SwiftUI

struct UpcomingView: View {
    var viewmodel = ViewModel()
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                switch viewmodel.upcomingStatus {
                case .notStarted:
                    EmptyView()
                case .fetching:
                    ProgressView().frame(width: geo.size.width,height: geo.size.height)
                case .success:
                    VerticalListView(titles: viewmodel.upcomingMovies)
                    
                case .failure(let underlyingError):
                    Text(underlyingError.localizedDescription)
                }
                
            }
            .task {
                await viewmodel.getUpcomingMovies()
            }
        }
    }
}

#Preview {
    UpcomingView()
}
