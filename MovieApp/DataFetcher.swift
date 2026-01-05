//
//  DataFetcher.swift
//  MovieApp
//
//  Created by MacMini on 12/12/25.
//

import Foundation

struct DataFetcher {
    let tmdbAPIURL = APIConfig.shared?.tmdbBaseURL
    let tmdbAPIKey = APIConfig.shared?.tmdbAPIKey
    let youtubeSearchURL = APIConfig.shared?.youtubeSearchURL
    let youtubeAPIKey = APIConfig.shared?.youtubeAPIKey

    
    func fetchTitles(for media:String,by type:String,with title:String? = nil) async throws -> [Title] {
        
        let url = try buildURL(for: media, by: type,searchPhrase: title)
        guard let url2 = url else {
            throw NetworkError.urlBuildFailed
        }
        print(url)
        var titles = try await fetchAndDecode(url: url2, type: APIObject.self).results
        Constants.addPosterPath(to: &titles)

        return titles
    }
    func buildURL(for media: String, by type:String,searchPhrase: String? = nil) throws -> URL? {
        guard let baseurl = tmdbAPIURL else {
            throw NetworkError.missingConfig
        }
        guard let key = tmdbAPIKey else {
            throw NetworkError.missingConfig
        }
        
        var path = ""
        if type == "trending" {
            path = "3/\(type)/\(media)/day"
        }else if type == "top_rated" || type == "upcoming"{
            path = "3/\(media)/\(type)"
        } else if type == "search" {
            path = "3/\(type)/\(media)"
        }
        else {
            throw NetworkError.urlBuildFailed
        }
        var urlQueryItems = [URLQueryItem(name: "api_key", value: key)]
        if let searchPhrase {
            urlQueryItems.append(URLQueryItem(name: "query", value: searchPhrase))
        }
        guard let url = URL(string: baseurl)?
            .appending(path: path)
            .appending(queryItems: urlQueryItems) else{
            throw NetworkError.urlBuildFailed
        }
        return url
    }
    func fetchVideoId(for title:String) async throws -> String {
        guard let baseurl = youtubeSearchURL else {
            throw NetworkError.missingConfig
        }
        guard let key = youtubeAPIKey else {
            throw NetworkError.missingConfig
        }
        let search = title + YoutubeURLStrings.space.rawValue + YoutubeURLStrings.trailer.rawValue
        guard let videoURL = URL(string: baseurl)?.appending(queryItems: [
            URLQueryItem(name: YoutubeURLStrings.queryShorten.rawValue, value: search),
            URLQueryItem(name: YoutubeURLStrings.key.rawValue, value: key)
        ])else {
            throw NetworkError.urlBuildFailed
        }
        print(videoURL)
        return try await fetchAndDecode(url: videoURL, type: YoutubeSearchResponse.self).items?.first?.id?.videoId ?? ""
    }
    func fetchAndDecode<T:Decodable>(url: URL, type: T.Type) async throws -> T {
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let httpRespones = response as? HTTPURLResponse, httpRespones.statusCode == 200 else {
            throw NSError(domain: "DataFetcher", code: (response as? HTTPURLResponse)?.statusCode ?? -1, userInfo: [NSLocalizedDescriptionKey: "invalid status code"])
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(type, from: data)
    }
    
}
