//
//  CustomFavorViewModel.swift
//  The Favour
//
//  Created by Atta khan on 15/08/2023.
//

import SwiftUI
import Combine

final class CustomFavorViewModel: ObservableObject {
    private let favorManager: FavorManager = FavorManager()
    private var cancellables = Set<AnyCancellable>()
    var locationManager: LocationManager = LocationManager()

    
    @Published var shouldShowLoader: Bool = false

    func getUserFavor() {
        shouldShowLoader = true
        favorManager.userFavors()
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    print("Couldn't login: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                if let data = model.data {
                }
                
            }
            .store(in: &cancellables)
    }
//    func postFavor() {
//        shouldShowLoader = true
//        let category_id = self.selectedService?.id ?? 0
//        let favor = Favor(title: title, tags: tags, category_id: String(category_id), revisions: "3", total_price: "1000", status: "published", description: desc, meta_data: desc, lat: String(lat), lng: String(lng), address: address, search_tags: tags, favor_id: favor_id, icon: "")
//        //guard let mediaImage = Media(withImage: image, forKey: "icon") else { return }
//        favorManager.favorPost(favor: favor, media: nil)
//            .sink { [weak self] completion in
//                switch completion {
//                case let .failure(error):
//                    self?.shouldShowLoader = false
//                    print("Couldn't Post Favor: \(error)")
//                case .finished:
//                    self?.shouldShowLoader = false
//                    break
//                }
//            } receiveValue: { [weak self] model in
//                self?.isAlertShow = true
//                self?.isNewFavorAdded = model.error ?? false
//                if let message = model.message {
//                    self?.alertMsg = message
//                }
//            }
//            .store(in: &cancellables)
//    }
//
//    func deleteFavor(id: Int) {
//        shouldShowLoader = true
//        favorManager.favorDelete(favor_id: id)
//            .sink { [weak self] completion in
//                switch completion {
//                case let .failure(error):
//                    self?.shouldShowLoader = false
//                    print("Couldn't Delete Favor: \(error)")
//                case .finished:
//                    self?.shouldShowLoader = false
//                    break
//                }
//            } receiveValue: { [weak self] model in
//                self?.isAlertShow = true
//                self?.isNewFavorAdded = model.error ?? false
//                if let message = model.message {
//                    self?.alertMsg = message
//                }
//            }
//            .store(in: &cancellables)
//    }
    
}

