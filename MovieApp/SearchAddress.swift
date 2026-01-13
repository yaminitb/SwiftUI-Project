//
//  SearchAddress.swift
//  LoginApp
//
//  Created by MacMini on 08/01/26.
//

import SwiftUI

struct SearchAddress: View {
    @State private var search: String = ""
    @StateObject private var locationManager = LocationManager()
    @StateObject private var vm = SearchResultsViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                List(vm.places) {place in
                    Text(place.name)
                }
            }.searchable(text: $search)
                .onChange(of: search,perform: { searchText in
                    vm.search(text: searchText, region: locationManager.region)
                })
                .navigationTitle("Places")
        }
    }
}

#Preview {
    SearchAddress()
}
