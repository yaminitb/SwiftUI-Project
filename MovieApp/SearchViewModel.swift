//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by MacMini on 20/12/25.
//

import Foundation

@Observable
class SearchViewModel {
    private(set) var errorMesage : String?
    private(set) var searchTitles: [Title] = []
    private let dataFetcher = DataFetcher()
    
    func getSearchTitles(by media: String,for title:String) async {
        do {
            errorMesage = nil
            if title.isEmpty {
                searchTitles = try await dataFetcher.fetchTitles(for: media, by: "trending")
            }else {
                searchTitles = try await dataFetcher.fetchTitles(for: media, by: "search",with: title)
            }
        }catch {
            errorMesage = error.localizedDescription
            print(error.localizedDescription)
        }
    }
}
