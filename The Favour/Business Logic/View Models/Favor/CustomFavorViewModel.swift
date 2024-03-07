//
//  CustomFavorViewModel.swift
//  The Favour
//
//  Created by Atta khan on 15/08/2023.
//

import SwiftUI


// MARK: - CUSTOM FAVOR

extension FavorViewModel {
    func postCustomFavor() {
        shouldShowLoader = true
        let category_id = self.selectedService?.id ?? 0
        let favor = Favor(title: title, tags: tags, category_id: String(category_id), revisions: "3", total_price: "1000", status: "published", description: desc, meta_data: desc, lat: String(lat), lng: String(lng), address: address, search_tags: tags, favor_id: favor_id, icon: "")

        favorManager.customfavorPost(favor: favor)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    print("Couldn't Post Favor: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                self?.isAlertShow = true
                self?.isNewFavorAdded = model.error ?? false
                if let message = model.message {
                    self?.alertMsg = message
                }
            }
            .store(in: &cancellables)
    }
    func getCustomFavor() {
        shouldShowLoader = true
        let param = FavorRequest(keyword: search_keyword, category_id: category_id, radius: radius, lat: String(locationManager.latitude), lng: String(locationManager.longitude), services_page_size: services_page_size, page: page, page_size: page_size, is_services: is_services)
        favorManager.getCustomFavor(params: param)
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
                    self?.customFavor = data
                }
            }
            .store(in: &cancellables)
    }
    func deleteCustomFavor(id: Int) {
        shouldShowLoader = true
        favorManager.deleteCustomFavor(favor_id: id)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    print("Couldn't Delete Favor: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                self?.isAlertShow = true
                self?.isNewFavorAdded = model.error ?? false
                if let message = model.message {
                    self?.alertMsg = message
                }
            }
            .store(in: &cancellables)
    }
}


// MARK: - CUSTOM FAVOR BOOKING

extension FavorViewModel {
    func customFavorBooking(id: Int, price: String, details: String) {
        shouldShowLoader = true
        favorManager.bookingCustomFavor(favor_id: id, total_price: price, details: details)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    print("Couldn't Delete Favor: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                print(model)
            }
            .store(in: &cancellables)
    }
    
}


// MARK: - CUSTOM FAVOR BY SELLER

extension FavorViewModel {
    func getCustomSellerFavor() {
        shouldShowLoader = true
        favorManager.getCustomSellerFavor()
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    print("Couldn't Delete Favor: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                print(model)
            }
            .store(in: &cancellables)
    }
    func getCustomSellerFavorDetail(id: String) {
        shouldShowLoader = true
        favorManager.getCustomSellerFavorDetail(id: id)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    print("Couldn't Delete Favor: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                print(model)
            }
            .store(in: &cancellables)
    }
}
