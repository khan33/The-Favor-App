//
//  FavorBookingManager.swift
//  The Favour
//
//  Created by Atta khan on 25/06/2023.
//


import Foundation
import Combine

protocol FavorBookingManagerProtocol: AnyObject {
    var networkManager: NetworkManagerProtocol { get }  
    // Booking Api's by buyer user
    func getUserBookingFavorList() -> AnyPublisher<FavorBookingModel, Error>
    func getBookingDetailById(bookingId: Int) -> AnyPublisher<FavorBookingModel, Error>
    func userAddBookingFavor(favor: BookingFavor ) -> AnyPublisher<FavorBookedModel, Error>
    func userUpdateBookingFavor(favor: BookingFavor ) -> AnyPublisher<FavorBookingModel, Error>
    func userBookingApproved(bookingId: Int, status: String ) -> AnyPublisher<FavorBookingModel, Error>
    func useraddRating(bookingId: String, rating: String, comments: String ) -> AnyPublisher<FavorBookingModel, Error>
    // Booking Api's by seller user
    func getSellerBookingFavorList(favorId: String) -> AnyPublisher<FavorBookingModel, Error>
    func getSellerBookingAction(booking_id: Int, status: String) -> AnyPublisher<FavorBookingModel, Error>
    func getSellerBookingStart(booking_id: Int, lat: Double, lng: Double) -> AnyPublisher<FavorBookingModel, Error>
    func getSellerBookingComplete(booking_id: Int, lat: Double, lng: Double) -> AnyPublisher<FavorBookingModel, Error>
    func getSellerBookingDetailById(bookingId: Int) -> AnyPublisher<FavorBookingDetailModel, Error>
    func bookingPaymentUpdate(bookingId: Int, status: String) -> AnyPublisher<UpdatePayemntResponseModel, Error>
}
final class FavorBookingManager: FavorBookingManagerProtocol {
    let networkManager: NetworkManagerProtocol
    init() {
        networkManager = NetworkManager()
    }
    func getUserBookingFavorList() -> AnyPublisher<FavorBookingModel, Error> {
        let endPoint = Endpoint.getUserFavorbookingList
        return networkManager.request(type: FavorBookingModel.self, url: endPoint.url, httpMethod: .GET, headers: endPoint.headers, parameters: nil)
    }
    func getBookingDetailById(bookingId: Int) -> AnyPublisher<FavorBookingModel, Error> {
        let endPoint = Endpoint.getBookingDetailById(id: String(bookingId))
        return networkManager.request(type: FavorBookingModel.self, url: endPoint.url, httpMethod: .GET, headers: endPoint.headers, parameters: nil)
    }
    func userAddBookingFavor(favor: BookingFavor ) -> AnyPublisher<FavorBookedModel, Error> {
        let endPoint = Endpoint.bookingFavor
        let params = [
            "total_price": favor.total_price,
            "favor_date": favor.favor_date,
            "favor_time": favor.favor_time,
            "details": favor.details,
            "lat": favor.lat,
            "lng": favor.lng,
            "address" : favor.address,
            "favor_id": favor.favor_id
        ]
        return networkManager.request(type: FavorBookedModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
    }
    func userUpdateBookingFavor(favor: BookingFavor ) -> AnyPublisher<FavorBookingModel, Error> {
        let endPoint = Endpoint.updateBookingFavor
        let params = [
            "total_price": favor.total_price,
            "favor_date": favor.favor_date,
            "favor_time": favor.favor_time,
            "details": favor.details,
            "lat": favor.lat,
            "lng": favor.lng,
            "address" : favor.address,
            "favor_id": favor.favor_id
        ]
        return networkManager.request(type: FavorBookingModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
    }
    func userDeleteBookingFavor(bookingId: Int, status: String ) -> AnyPublisher<FavorBookingModel, Error> {
        let endPoint = Endpoint.deleteBookingFavor
        let params = [
            "booking_id": String(bookingId),
            "status": status
        ]
        return networkManager.request(type: FavorBookingModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
    }
    func userBookingApproved(bookingId: Int, status: String ) -> AnyPublisher<FavorBookingModel, Error> {
        let endPoint = Endpoint.bookingApproved
        let params = [
            "booking_id": String(bookingId)
        ]
        return networkManager.request(type: FavorBookingModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
    }
    func useraddRating(bookingId: String, rating: String, comments: String ) -> AnyPublisher<FavorBookingModel, Error> {
        let endPoint = Endpoint.addRating
        let params = [
            "booking_id": bookingId,
            "rating": rating,
            "comments" : comments
        ]
        return networkManager.request(type: FavorBookingModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
    }
    func getSellerBookingFavorList(favorId: String) -> AnyPublisher<FavorBookingModel, Error> {
        let endPoint = Endpoint.sellerBooking(id: favorId)

        return networkManager.request(type: FavorBookingModel.self, url: endPoint.url, httpMethod: .GET, headers: endPoint.headers, parameters: nil)
    }
    func getSellerBookingAction(booking_id: Int, status: String) -> AnyPublisher<FavorBookingModel, Error> {
        let endPoint = Endpoint.sellerBookingAction
        let params = [
            "booking_id": String(booking_id),
            "status": status
        ]
        return networkManager.request(type: FavorBookingModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
    }
    func getSellerBookingStart(booking_id: Int, lat: Double, lng: Double) -> AnyPublisher<FavorBookingModel, Error> {
        let endPoint = Endpoint.sellerBookingStart
        let params = [
            "booking_id": String(booking_id),
            "lat": String(lat),
            "lng": String(lng)
        ]
        return networkManager.request(type: FavorBookingModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
    }
    func getSellerBookingComplete(booking_id: Int, lat: Double, lng: Double) -> AnyPublisher<FavorBookingModel, Error> {
        let endPoint = Endpoint.sellerBookingComplete
        let params = [
            "booking_id": String(booking_id),
            "lat": String(lat),
            "lng": String(lng)
        ]
        return networkManager.request(type: FavorBookingModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
    }
    func getSellerBookingDetailById(bookingId: Int) -> AnyPublisher<FavorBookingDetailModel, Error> {
        let endPoint = Endpoint.getSellerBookingDetailById(id: String(bookingId))
        return networkManager.request(type: FavorBookingDetailModel.self, url: endPoint.url, httpMethod: .GET, headers: endPoint.headers, parameters: nil)
    }
    func bookingPaymentUpdate(bookingId: Int, status: String) -> AnyPublisher<UpdatePayemntResponseModel, Error> {
        let endPoint = Endpoint.paymentUpdate
        let params: [String: Any] = [
            "booking_id": bookingId,
            "status": status
        ]
        return networkManager.request(type: UpdatePayemntResponseModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
    }
}
