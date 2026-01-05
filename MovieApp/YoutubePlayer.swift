//
//  YoutubePlayer.swift
//  MovieApp
//
//  Created by MacMini on 19/12/25.
//

import SwiftUI
import WebKit

struct YoutubePlayer : UIViewRepresentable {
    
    let videoId: String
    let webview = WKWebView()
    let youtubeBaseURL = APIConfig.shared?.youtubeBaseURL
    func makeUIView(context: Context) -> some UIView {
        webview
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let baseURLString = youtubeBaseURL, let baseURL = URL(string: baseURLString + videoId) else {
            return
        }
        let url = baseURL//.appending(path: videoId)
        webview.load(URLRequest(url: url))
    }
}
