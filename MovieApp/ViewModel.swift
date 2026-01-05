//
//  ViewModel.swift
//  MovieApp
//
//  Created by MacMini on 15/12/25.
//

import Foundation

@Observable
class ViewModel {
    
    enum FetchStatus {
        case notStarted
        case fetching
        case success
        case failure(underlyingError: Error)
    }
    
    private(set) var homeStatus : FetchStatus = .notStarted
    private(set) var videoIdStatus : FetchStatus = .notStarted
    private(set) var upcomingStatus : FetchStatus = .notStarted

    private let dataFetcher = DataFetcher()
    var trendingMovies : [Title] = []
    var trendingTV : [Title] = []
    var topRatedMovies : [Title] = []
    var topRatedTV : [Title] = []
    var upcomingMovies : [Title] = []
    
    var heroTitle  = Title.previewTitles[0]
    var videoId = ""
    func getTitles() async {
        homeStatus = .fetching
        if trendingMovies.isEmpty {
            do {
                async let tmovies =  try await dataFetcher.fetchTitles(for: "movie",by: "trending")
                async let ttv =  try await dataFetcher.fetchTitles(for: "tv",by: "trending")
                async let topmovies =  try await dataFetcher.fetchTitles(for: "movie",by: "top_rated")
                async let toptv = try await dataFetcher.fetchTitles(for: "tv",by: "top_rated")
                trendingMovies = try await tmovies
                trendingTV = try await ttv
                topRatedMovies = try await topmovies
                topRatedTV = try await toptv
                
                if let title = trendingMovies.randomElement() {
                    heroTitle = title
                }
                homeStatus = .success
            }catch {
                homeStatus = .failure(underlyingError: error)
            }
        }else {
            homeStatus = .success
        }
        
    }
    func getVideoId(for title: String) async {
        videoIdStatus = .fetching
        
        do {
            videoId = try await dataFetcher.fetchVideoId(for: title)
            videoIdStatus = .success
        }catch {
            videoIdStatus = .failure(underlyingError: error)
        }
    }
    func getUpcomingMovies() async {
        
        upcomingStatus = .fetching
        do {
            upcomingMovies = try await dataFetcher.fetchTitles(for: "movie", by: "upcoming")
            upcomingStatus = .success
            
        }catch {
            upcomingStatus = .failure(underlyingError: error)
        }
    }
}
