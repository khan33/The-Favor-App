//
//  Endpoint.swift
//  The Favour
//
//  Created by Atta khan on 24/05/2023.
//

import Foundation


struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = NetworkConstants.scheme
        components.host = NetworkConstants.host
        components.path = NetworkConstants.path + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    var headers: [String: String] {
        var headers: [String: String] = [ "Content-Type": "application/json"
                                        ]
        if let token = KeychainManager.getAuthToken() {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }
}

extension Endpoint {
    static var login: Self {
        return Endpoint(path: NetworkConstants.loginService)
    }
    
    static var register: Self {
        return Endpoint(path: NetworkConstants.register)
    }
    
    static var socialLogin: Self {
        return Endpoint(path: NetworkConstants.socialLogin)
    }
    
    static var logout: Self {
        return Endpoint(path: NetworkConstants.logout)
    }
    
    static var resetPassword: Self {
        return Endpoint(path: NetworkConstants.resetPassword)
    }
    
    static var forgoPassword: Self {
        return Endpoint(path: NetworkConstants.forgotPassword)
    }
    
    static var updateProfile: Self {
        return Endpoint(path: NetworkConstants.updateUserProfile)
    }
    
    static func getUser(Id: String) -> Self {
        return Endpoint(path: NetworkConstants.getUserDetail, queryItems: [URLQueryItem(name: "id", value: Id)])
    }
    static var getUserFavor: Self {
        return Endpoint(path: NetworkConstants.getUserFavor, queryItems: [
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "page_size", value: "20"),

        ])
    }
    static var userPostFavor: Self {
        return Endpoint(path: NetworkConstants.favorPost)
    }
    
    static var userDeleteFavor: Self {
        return Endpoint(path: NetworkConstants.deleteFavor)
    }
    
    static var userUpdateFavor: Self {
        return Endpoint(path: NetworkConstants.favorUpdate)
    }
    
    static func getFavor(request: FavorRequest) -> Self {
        return Endpoint(path: NetworkConstants.getFavor, queryItems: [
            URLQueryItem(name: "keyword", value: request.keyword),
            URLQueryItem(name: "category_id", value: request.category_id),
            URLQueryItem(name: "radius", value: request.radius),
            URLQueryItem(name: "lat", value: request.lat),
            URLQueryItem(name: "lng", value: request.lng),
            URLQueryItem(name: "services_page_size", value: request.services_page_size),
            URLQueryItem(name: "page", value: request.page),
            URLQueryItem(name: "page_size", value: request.page_size),
            URLQueryItem(name: "is_services", value: request.is_services),
        ])
    }
    
    
    static func getFavorById(Id: String) -> Self {
        return Endpoint(path: NetworkConstants.getFavorDetailById, queryItems: [URLQueryItem(name: "id", value: Id)])
    }
    
    
    static var getService: Self {
        return Endpoint(path: NetworkConstants.getServices, queryItems: [
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "page_size", value: "50"),
        ])
    }
    
    
    

    static var getUserFavorbookingList: Self {
        return Endpoint(path: NetworkConstants.favorBookingByUser)
    }
    
    static func getBookingDetailById(id: String) -> Self {
        return Endpoint(path: NetworkConstants.getBookingDetail, queryItems: [
            URLQueryItem(name: "booking_id", value: id)
        ])
    }
    
    static var bookingFavor: Self {
        return Endpoint(path: NetworkConstants.favorBooking)
    }
    
    static var updateBookingFavor: Self {
        return Endpoint(path: NetworkConstants.updateBookingFavor)
    }
    static var deleteBookingFavor: Self {
        return Endpoint(path: NetworkConstants.deleteBookingFavor)
    }
    
    static var bookingApproved: Self {
        return Endpoint(path: NetworkConstants.bookingApproved)
    }
    
    static var addRating: Self {
        return Endpoint(path: NetworkConstants.addRating)
    }

    static func sellerBooking(id: String) ->Self {
        return Endpoint(path: NetworkConstants.seller_booking, queryItems: [
            URLQueryItem(name: "favor_id", value: id)
        ])
    }
    static var sellerBookingAction: Self {
        return Endpoint(path: NetworkConstants.seller_booking_action)
    }
    static var sellerBookingStart: Self {
        return Endpoint(path: NetworkConstants.seller_booking_start)
    }
    static var sellerBookingComplete: Self {
        return Endpoint(path: NetworkConstants.seller_complete_booking)
    }
    static func getSellerBookingDetailById(id: String) -> Self {
        return Endpoint(path: NetworkConstants.seller_booking_details, queryItems: [
            URLQueryItem(name: "booking_id", value: id)
        ])
    }
    static var paymentUpdate: Self {
        return Endpoint(path: NetworkConstants.payemnt_update)
    }
    
}
