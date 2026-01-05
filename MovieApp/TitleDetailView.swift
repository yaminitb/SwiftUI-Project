//
//  TitleDetailView.swift
//  MovieApp
//
//  Created by MacMini on 19/12/25.
//

import SwiftUI
import SwiftData

struct TitleDetailView: View {
    let title: Title
    var titleName : String {
        return (title.name ?? title.title) ?? ""
    }
    var viewmodel = ViewModel()
    @Environment(\.modelContext) var modelContext
    var body: some View {
        GeometryReader { geometry in
            switch viewmodel.videoIdStatus {
            case .notStarted:
                EmptyView()
            case .fetching:
                ProgressView()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.85)
            case .success:
                ScrollView{
                    LazyVStack (alignment: .leading) {
                        YoutubePlayer(videoId: viewmodel.videoId)
                            .aspectRatio(1.3, contentMode: .fit)
                        
                        Text(titleName)
                            .font(.title2)
                            .bold()
                            .padding(5)
                            .padding(.top, -10)
                        
                        Text(title.overview ?? "")
                            .padding(5)
                        
                        HStack {
                            Spacer()
                            Button {
                                let saveTitle = title
                                saveTitle.title = titleName
                                modelContext.insert(saveTitle)
                                try? modelContext.save()
                            }label: {
                                Text(Constants.downloadString)
                                    .ghostButtonStyle()
                            }
                            Spacer()
                        }
                    }
                   
                    
                }
            case .failure(let underlyingError):
                Text(underlyingError.localizedDescription)
            }
            
        }
        .task {
           await viewmodel.getVideoId(for: titleName)
        }
    }
}

#Preview {
    TitleDetailView(title: Title.previewTitles[0])
}
