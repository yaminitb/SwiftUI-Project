//
//  VerticalListView.swift
//  MovieApp
//
//  Created by MacMini on 20/12/25.
//

import SwiftUI

struct VerticalListView: View {
    var titles : [Title]
    var body: some View {
        List(titles) { title in
            NavigationLink {
                TitleDetailView(title: title)
            }label: {
                AsyncImage(url: URL(string: title.posterPath ?? "")) {image in
                    HStack {
                        
                        image.resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 10))
                        Text(title.title ?? title.name ?? "")
                            .bold()

                    }
                }placeholder: {
                    ProgressView()
                }
            .frame(height: 150)
            }
                
        }
    }
}

#Preview {
    VerticalListView(titles: Title.previewTitles)
}
