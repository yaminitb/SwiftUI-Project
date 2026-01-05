//
//  HomeView.swift
//  MovieApp
//
//  Created by MacMini on 11/12/25.
//

import SwiftUI
import SwiftData
struct HomeView: View {
    
    //var heroTestTitle = Constants.testTitleURL
    let viewModel = ViewModel()
    @State private var titleDetailPath = NavigationPath()
    @Environment(\.modelContext) var modelContext
    var body: some View {
        NavigationStack(path: $titleDetailPath) {
            GeometryReader { geo in
                ScrollView(.vertical) {
                    switch viewModel.homeStatus {
                    case .notStarted:
                        EmptyView()
                    case .fetching:
                        ProgressView()
                            .frame(width: geo.size.width,height: geo.size.height)
                    case .success:
                        LazyVStack{
                            AsyncImage(url: URL(string: viewModel.heroTitle.posterPath ?? "")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .overlay {
                                        LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.8),Gradient.Stop(color: .gradient, location: 1)], startPoint: .top, endPoint: .bottom)
                                    }
                            }placeholder: {
                                ProgressView()
                            }
                            .frame(width: geo.size.width,height: geo.size.height * 0.85)
                            HStack {
                                Button{
                                    titleDetailPath.append(viewModel.heroTitle)
                                }label: {
                                    Text(Constants.playString)
                                        .ghostButtonStyle()
                                    
                                }
                                Button{
                                    modelContext.insert(viewModel.heroTitle)
                                    try? modelContext.save()
                                }label: {
                                    Text(Constants.downloadString)
                                        .ghostButtonStyle()
                                }
                            }
                            HorizontalListView(header: Constants.trendingMovieString,titles: viewModel.trendingMovies) { title in
                                titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.trendingTVString,titles: viewModel.trendingTV){ title in
                                titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.topRatedMovieString,titles: viewModel.topRatedMovies){ title in
                                titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.topRatedTVString,titles: viewModel.topRatedTV){ title in
                                titleDetailPath.append(title)
                            }
                            
                            
                            
                        }
                       
                    case .failure(let underlyingError):
                        Text("")
                    }
                    
                }
                .navigationDestination(for: Title.self) { title in
                    TitleDetailView(title: title)
                }
                .task {
                    await viewModel.getTitles()
                }
            }
        }
        
    }
}

#Preview {
    HomeView()
}
