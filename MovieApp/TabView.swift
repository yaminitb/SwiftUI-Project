//
//  TabView.swift
//  MovieApp
//
//  Created by MacMini on 13/01/26.
//

import SwiftUI

struct TabView2: View {
    var body: some View {
        TabView{
            Tab(Constants.homeString,systemImage: Constants.homeIconString){
                HomeView()
            }
            Tab(Constants.upcomingString,systemImage: Constants.upcomingIconString){
                UpcomingView()
            }
            Tab(Constants.searchString,systemImage: Constants.searchIconString){
                SearchView()
            }
            Tab(Constants.downloadString,systemImage: Constants.downloadIconString){
                DownloadView()
            }
        }
    }
}

#Preview {
    TabView2()
}
