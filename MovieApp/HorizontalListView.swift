//
//  HorizontalListView.swift
//  MovieApp
//
//  Created by MacMini on 12/12/25.
//

import SwiftUI

struct HorizontalListView: View {
    var header : String
    var titles : [Title]//= [Constants.testTitleURL, Constants.testTitleURL2, Constants.testTitleURL3]
    let onSelect : (Title) -> Void
    var body: some View {
        VStack(alignment: .leading) {
            Text(header)
                .font(.title)
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach (titles) { title in
                        AsyncImage(url: URL(string: title.posterPath ?? "")){image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        }placeholder: {
                            ProgressView()
                        }
                        .frame(width: 120,height: 200)
                        .onTapGesture {
                            onSelect(title)
                        }
                    }
                }
            }
        }.frame(height: 250)
            .padding()
    }
}

#Preview {
    HorizontalListView(header: Constants.trendingMovieString,titles: Title.previewTitles) { title in
    }
}
