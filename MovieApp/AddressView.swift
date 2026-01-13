//
//  AddressView.swift
//  LoginApp
//
//  Created by MacMini on 08/01/26.
//

import SwiftUI

struct AddressView: View {
    @State var vm = LocationService()
    var body: some View {
        NavigationStack {
            if vm.results.isEmpty {
                ContentUnavailableView("No Results", systemImage: "questionmark.square.dashed")
            }else{
                List(vm.results) { result in
                    VStack(alignment: .leading) {
                        Text(result.title)
                        Text(result.subtitle)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .searchable(text: $vm.query)
    }
}

#Preview {
    AddressView()
}
