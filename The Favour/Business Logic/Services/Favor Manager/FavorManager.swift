//
//  FavorManager.swift
//  The Favour
//
//  Created by Atta khan on 25/06/2023.
//

import Foundation
import Combine

protocol FavorManagerProtocol: AnyObject {
    var networkManager: NetworkManagerProtocol { get }
    func userFavors() -> AnyPublisher<FavorModel, Error>
    func favorPost(favor: Favor, media: [Media]? ) -> AnyPublisher<FavorModel, Error>
    func favorDelete(favor_id: Int) -> AnyPublisher<FavorModel, Error>

    
    func favorUpdate(favor: Favor ) -> AnyPublisher<LoginModel, Error>
    func getFavor(params: FavorRequest) -> AnyPublisher<FavorModel, Error>
    func getFavorById(id: String) -> AnyPublisher<LoginModel, Error>
    func getService() -> AnyPublisher<ServiceModel, Error>

}

final class FavorManager: FavorManagerProtocol {
    
    let networkManager: NetworkManagerProtocol
        
    init() {
        networkManager = NetworkManager()
    }
    
    func userFavors() -> AnyPublisher<FavorModel, Error> {
        let endPoint = Endpoint.getUserFavor
        return networkManager.request(type: FavorModel.self, url: endPoint.url, httpMethod: .GET, headers: endPoint.headers, parameters: nil)
    }
    
    
    func favorDelete(favor_id: Int) -> AnyPublisher<FavorModel, Error> {
        let endPoint = Endpoint.userDeleteFavor
        let params = [ "favor_id": favor_id]
        return networkManager.request(type: FavorModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
    }

    func favorPost(favor: Favor, media: [Media]?) -> AnyPublisher<FavorModel, Error> {
        var endPoint = Endpoint.userPostFavor

        if favor.favor_id != "0" {
            endPoint = Endpoint.userUpdateFavor
        }
        let params = [
            "title": favor.title,
            "tags": favor.tags,
            "category_id": favor.category_id,
            "revisions": favor.revisions,
            "total_price": favor.total_price,
            "status": favor.status,
            "description": favor.description,
            "meta_data": favor.meta_data,
            "lat": favor.lat,
            "lng": favor.lng,
            "address" : favor.address,
            "search_tags": favor.search_tags,
            "favor_id": favor.favor_id
        ]
        
        return networkManager.request(type: FavorModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
        
        
//        return networkManager.mutlipartResuest(type: FavorModel.self, url: endPoint.url, headers: endPoint.headers, parameters: params, media: media)
    }

    func favorUpdate(favor: Favor ) -> AnyPublisher<LoginModel, Error> {
        let endPoint = Endpoint.userUpdateFavor
        let params = [
            "title": favor.title,
            "tags": favor.tags,
            "category_id": favor.category_id,
            "revisions": favor.revisions,
            "total_price": favor.total_price,
            "status": favor.status,
            "description": favor.description,
            "meta_data": favor.meta_data,
            "lat": favor.lat,
            "lng": favor.lng,
            "address" : favor.address,
            "search_tags": favor.search_tags,
            "favor_id": favor.favor_id
        ]
        return networkManager.request(type: LoginModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
    }
    
    func getFavor(params: FavorRequest) -> AnyPublisher<FavorModel, Error> {
        let endPoint = Endpoint.getFavor(request: params)
        return networkManager.request(type: FavorModel.self, url: endPoint.url, httpMethod: .GET, headers: endPoint.headers, parameters: nil)
    }
    func getFavorById(id: String) -> AnyPublisher<LoginModel, Error> {
        let endPoint = Endpoint.getFavorById(Id: id)
        return networkManager.request(type: LoginModel.self, url: endPoint.url, httpMethod: .GET, headers: endPoint.headers, parameters: nil)
    }
    
    func getService() -> AnyPublisher<ServiceModel, Error> {
        let endPoint = Endpoint.getService
        return networkManager.request(type: ServiceModel.self, url: endPoint.url, httpMethod: .GET, headers: endPoint.headers, parameters: nil)

    }


    
    
}


struct Favor {
    let title: String?
    let tags: String?
    let category_id: String?
    let revisions: String?
    let total_price: String?
    let status: String?
    let description: String?
    let meta_data: String?
    let lat: String?
    let lng: String?
    let address: String?
    let search_tags: String?
    let favor_id: String?
    let icon: String?
}

struct BookingFavor {
    let total_price: String
    let favor_date: String
    let favor_time: String
    let details: String
    let lat: String
    let lng: String
    let address: String
    let favor_id: String
    
}
