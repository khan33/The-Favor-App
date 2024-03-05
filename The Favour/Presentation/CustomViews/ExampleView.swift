//
//  ExampleView.swift
//  The Favour
//
//  Created by Atta khan on 09/07/2023.
//

import SwiftUI
import Combine
import CoreLocation

struct ExampleView: View {

    @StateObject private var locationManager = LocationManager()
    @State private var posts: [Post] = []

    var body: some View {
        
        VStack {
            //SliderHack()
        }

        //CountrySelectionView()
    }
    
   
    
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}



struct CountrySelectionView: View {
//    @ObservedObject var viewModel = CountrySelectionViewModel()
    @StateObject private var viewModel: FavorViewModel = FavorViewModel()

    @State private var showPicker = false
    @FocusState private var isPickerFocused: Bool

    var body: some View {
        VStack {
            FavorTextField(placeholder: "Title", leftImage: nil, rightImage: nil, text: $viewModel.service) {
                showPicker = true
            }
            if showPicker {
                Picker(selection: $viewModel.service, label: Text("")) {
                    ForEach(viewModel.serviceName, id: \.self) { country in
                        Text(country).tag(country)
                    }
                }
                .pickerStyle(InlinePickerStyle())
                .focused($isPickerFocused) // Bind picker's focus to the focus state
                .onChange(of: viewModel.serviceName) { _ in
                    isPickerFocused = false // Dismiss the picker after selection
                }

            }
            
            FavorTextField(placeholder: "Add Tags", leftImage: nil, rightImage: nil, text: $viewModel.tags)


            
        }
        .padding()
        .onAppear {
            viewModel.getService()
        }
    }
}



class CountrySelectionViewModel: ObservableObject {
    @Published var countries = ["USA", "Canada", "UK", "Germany", "France", "Japan"] // Add more countries as needed
    @Published var selectedCountry = "" // Initially set to an empty string

    func selectCountry(_ country: String) {
        selectedCountry = country
    }
}




class APIService {
    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Post].self, from: data)
    }
}
struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
