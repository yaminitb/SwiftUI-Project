//
//  DownloadView.swift
//  MovieApp
//
//  Created by MacMini on 21/12/25.
//

import SwiftUI
import SwiftData

struct DownloadView: View {
    @Query var savedTitles : [Title]
    var body: some View {
        NavigationStack {
            if savedTitles.isEmpty {
                Text("No downloads")
                    .padding()
                    .font(.title3)
                    .bold()
            }else{
                VerticalListView(titles: savedTitles)
            }
        }
        
    }
}

#Preview {
    DownloadView()
}
