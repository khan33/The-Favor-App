//
//  FavorViewModel.swift
//  The Favour
//
//  Created by Atta khan on 07/07/2023.
//


import Foundation
import Combine
import AuthenticationServices
import Firebase
import CryptoKit
import SwiftUI
import CoreLocation


final class FavorViewModel: ObservableObject {
    private let favorManager: FavorManager = FavorManager()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var shouldShowLoader: Bool = false
    @Published var favors: [FavorList]? {
        didSet {
            updateCoordinatesArray()
        }
    }
    @Published var favorsByService: [FavorList]?

    @Published var popularServicFavors: [FavorList]?
    @Published var services: [ServiceModelData]?
    @Published var popularServices: [ServiceModelData]?

    @Published var screenTitle: String = "Post a favor"
    @Published var serviceName = [String]()
    @Published var title: String = ""
    @Published var desc: String = ""
    @Published var tags: String = "#test, #abc"
    @Published var address: String = ""
    @Published var lat: Double = 0.0
    @Published var lng: Double = 0.0
    @Published var imageURL: String?
    @Published var favor_id: String = "0"
    @Published var titleError: String = ""
    @Published var descError: String = ""
    @Published var tagsError: String = ""
    @Published var service : String = ""
    @Published var selectedService: ServiceModelData?
    
    @Published var isNewFavorAdded: Bool = false
    @Published var alertMsg: String = ""
    @Published var isAlertShow: Bool = false
    @Published var selectedImage: UIImage? = nil
    @Published var showImagePicker: Bool = false
    @Published var isValidPost = false
    @Published var favor_detail: FavorList?
    @Published var search_keyword: String = ""
    @Published var category_id: String = ""
    @Published var radius: String = "2000"
    
    @Published var services_page_size: String = "20"
    @Published var page: String = "1"
    @Published var page_size: String = "15"
    @Published var is_services: String = "true"
    
    @Published var locations : [CLLocationCoordinate2D] = []
    
    var locationManager: LocationManager = LocationManager()

    init() {
        isFavorPostValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValidPost, on: self)
            .store(in: &cancellables)
        

    }
    private func updateCoordinatesArray() {
        locations = favors?.map { CLLocationCoordinate2D(latitude: $0.lat ?? 0.0, longitude: $0.lng ?? 0.0) } ?? []
    }

    func validateInputs() -> Bool {
        var isValid = true
        
        // Validate username
        if title.isEmpty {
            titleError = "Favor Title is required"
            isValid = false
        } else {
            titleError = ""
        }
        
        
        if tags.isEmpty {
            tagsError = "Tags is required"
            isValid = false
        } else {
            tagsError = ""
        }
        
        
        if desc.isEmpty {
            descError = "Description is required"
            isValid = false
        } else {
            descError = ""
        }
       
        
        return isValid
    }
    
    func loadImageFromURL(imageURLString: String) {
        guard let imageURL = URL(string: imageURLString) else { return }

        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            guard let data = data, error == nil else { return }

            if let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.selectedImage = uiImage
                }
            }
        }.resume()

    }
    
    
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
                    self?.favors = data.filter { $0.active == "Yes" }
                }
                
            }
            .store(in: &cancellables)
    }
    
    func getFavor() {
        shouldShowLoader = true
        
        let param = FavorRequest(keyword: search_keyword, category_id: category_id, radius: radius, lat: String(locationManager.latitude), lng: String(locationManager.longitude), services_page_size: services_page_size, page: page, page_size: page_size, is_services: is_services)
        favorManager.getFavor(params: param)
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
                    if self?.category_id != "" {
                        self?.favorsByService = data
                        //self?.favorsByService?.sort{ $0.id ?? 0 < $1.id ?? 0 }
                    } else {
                        self?.favors = data
                        //self?.favors?.sort{ $0.id ?? 0 < $1.id ?? 0 }
                        self?.popularServicFavors = self?.favors
                    }

                }
                if let services = model.services {
                    self?.services = services
                    self?.services?.sort{ $0.id ?? 0 < $1.id ?? 0 }
                    
                    self?.popularServices = self?.services?.filter { $0.ispopular == true }
                    self?.popularServices?.insert(ServiceModelData(id: 0, name: "All", color: "", icon: "", active: true, ispopular: true), at: 0)

                }
            }
            .store(in: &cancellables)
    }
    
    func filterFavorbyService(service_id : Int) {
        if service_id != 0 {
            self.popularServicFavors = self.favors?.filter { $0.category_id ?? 0 == service_id }
            return
        }
        self.popularServicFavors = self.favors
        
    }
    
    
    
    
    func getService() {
        shouldShowLoader = true
        
        favorManager.getService()
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
                if model.error == false {
                    
                    
                    if let services = model.data {
                        self?.services = services
                        for item in services {
                            if let name = item.name {
                                self?.serviceName.append(name)
                            }
                        }
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func postFavor(_ image: UIImage?) {
        shouldShowLoader = true
        let category_id = self.selectedService?.id ?? 0
        let favor = Favor(title: title, tags: tags, category_id: String(category_id), revisions: "3", total_price: "1000", status: "published", description: desc, meta_data: desc, lat: String(lat), lng: String(lng), address: address, search_tags: tags, favor_id: favor_id, icon: "")
        //guard let mediaImage = Media(withImage: image, forKey: "icon") else { return }
        favorManager.favorPost(favor: favor, media: nil)
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
    
    func deleteFavor(id: Int) {
        shouldShowLoader = true
        favorManager.favorDelete(favor_id: id)
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

extension FavorViewModel {
    
    var isServiceValidPublisher: AnyPublisher<Bool, Never> {
        $selectedService
            .map { service in
                return service != nil
            }
            .eraseToAnyPublisher()
    }
    var isTitleValidPublisher: AnyPublisher<Bool, Never> {
        $title
            .map { title in
                return title.count >= 4
            }
            .eraseToAnyPublisher()
    }
    
    var isDesValidPublisher: AnyPublisher<Bool, Never> {
        $desc
            .map { desc in
                return desc.count >= 20
            }
            .eraseToAnyPublisher()
    }
    
    var isValidAddressPublisher: AnyPublisher<Bool, Never> {
        $address
            .map { address in
                return !address.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    
    var isValidImagePublisher: AnyPublisher<Bool, Never> {
        $selectedImage
            .map { img in
                return img != nil
            }
            .eraseToAnyPublisher()
    }
    
    
    
    var isFavorPostValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(
            isServiceValidPublisher,
            isTitleValidPublisher,
            isDesValidPublisher,
            isValidAddressPublisher
          )
//        .combineLatest(isValidImagePublisher)
        .map { isServiceValid, isTitleValid ,isDescValid, isAddressValid in
            return isServiceValid && isTitleValid && isDescValid && isAddressValid
        }
        .eraseToAnyPublisher()
      }

}
