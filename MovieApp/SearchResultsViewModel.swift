//
//  SearchResultsViewModel.swift
//  LoginApp
//
//  Created by MacMini on 08/01/26.
//

import Foundation
import MapKit
internal import Combine
@MainActor
class SearchResultsViewModel : NSObject, ObservableObject {
    @Published var places =  [PlaceModel]()
    func search(text: String, region: MKCoordinateRegion) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = text
        searchRequest.region = region
        searchRequest.resultTypes = .address
        searchRequest.addressFilter = .includingAll
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            self.places = response.mapItems.map(PlaceModel.init)
        }
        
    }
}
class AuthManager: ObservableObject {
    @Published var isAuthenticated = false // This value can change within the manager

    func login() {
        // Perform login logic
        self.isAuthenticated = true
    }

    func logout() {
        // Perform logout logic
        self.isAuthenticated = false
    }
}

struct PlaceModel : Identifiable
{
    let id = UUID()
    private var mapItem: MKMapItem
    init(mapItem: MKMapItem) {
        self.mapItem = mapItem
    }
    var name: String { mapItem.name ?? "Unknown" }
}

