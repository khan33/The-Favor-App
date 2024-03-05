//
//  AthenticationManager.swift
//  The Favour
//
//  Created by Atta khan on 24/05/2023.
//

import Foundation
import Combine

protocol AthenticationManagerProtocol: AnyObject {
    var networkManager: NetworkManagerProtocol { get }
    func login(email: String, password: String, fcm_token: String) -> AnyPublisher<LoginModel, Error>
    func signup(email: String, password: String, name: String, user_type: String, contact_number: String, address: String, dob: String, id_card: String, lat: String, lng: String) -> AnyPublisher<LoginModel, Error>
    
    func logout(token: String) -> AnyPublisher<LoginModel, Error>
    func resetPassword(email: String, password: String, token: String, password_confirmation: String) -> AnyPublisher<ResetPasswordModel, Error>
    func forgotPassword(email: String) -> AnyPublisher<ForgotPasswordModel, Error>
    
    func getUser(id: String) -> AnyPublisher<LoginModel, Error>

    func updateProfile(user: User) -> AnyPublisher<LoginModel, Error>
    func loginWithSocial(email: String, token: String, name: String, login_type: String) -> AnyPublisher<LoginModel, Error>
    
    func updateAttachmentFiles(params: [String: String]?, files: [Media]) -> AnyPublisher<LoginModel, Error>
    func updateUserProfile(id: String, name: String, contact_number: String, address: String, dob: String, lat: String, lng: String) -> AnyPublisher<LoginModel, Error>


    
}

final class AthenticationManager: AthenticationManagerProtocol {
    
    let networkManager: NetworkManagerProtocol
        
    init() {
        networkManager = NetworkManager()
    }
    
    func login(email: String, password: String, fcm_token: String) -> AnyPublisher<LoginModel, Error> {
        let endPoint = Endpoint.login
        let params = ["email": email, "password": password, "fcm_token" : fcm_token]
        return networkManager.request(type: LoginModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
    }
    
    func signup(email: String, password: String, name: String, user_type: String, contact_number: String, address: String, dob: String, id_card: String, lat: String, lng: String) -> AnyPublisher<LoginModel, Error> {
        let endPoint = Endpoint.register
        let params = [
            "name": name,
            "email": email,
            "password": password,
            "c_password": password,
            "user_type": user_type,
            "contact_number": contact_number,
            "address": address,
            "dob": dob,
            "id_card": id_card,
            "lat": lat,
            "lng": lng,
            "fcm_token": PrefsManager.shared.fcmKey
        ]
        return networkManager.request(type: LoginModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
    }
    
    func loginWithSocial(email: String, token: String, name: String, login_type: String) -> AnyPublisher<LoginModel, Error> {
        let endPoint = Endpoint.socialLogin
        let params = [
            "name": name,
            "email": email,
            "token": token,
            "login_type": login_type,
            "fcm_token": PrefsManager.shared.fcmKey
        ]
        return networkManager.request(type: LoginModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)

    }
    
    func updateUserProfile(id: String, name: String, contact_number: String, address: String, dob: String, lat: String, lng: String) -> AnyPublisher<LoginModel, Error> {
        let endPoint = Endpoint.updateProfile
        let params = [
            "id": id,
            "name": name,
            "contact_number": contact_number,
            "dob": dob,
            "lat": lat,
            "lng": lng,
            "address": address
        ]
        return networkManager.request(type: LoginModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
    }

    
    
    
    func logout(token: String) -> AnyPublisher<LoginModel, Error> {
        let endPoint = Endpoint.logout
        let params = ["token": token]
        return networkManager.request(type: LoginModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
    }
    func resetPassword(email: String, password: String, token: String, password_confirmation: String) -> AnyPublisher<ResetPasswordModel, Error> {
        let endPoint = Endpoint.resetPassword
        let params = ["email": email, "password": password, "token" : token, "password_confirmation": password_confirmation]
        return networkManager.request(type: ResetPasswordModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
    }
    func forgotPassword(email: String) -> AnyPublisher<ForgotPasswordModel, Error> {
        let endPoint = Endpoint.forgoPassword
        let params = ["email": email]
        return networkManager.request(type: ForgotPasswordModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
    }
    
    func getUser(id: String) -> AnyPublisher<LoginModel, Error> {
        let endPoint = Endpoint.getUser(Id: id)
        return networkManager.request(type: LoginModel.self, url: endPoint.url, httpMethod: .GET, headers: endPoint.headers, parameters: nil)
    }

    func updateProfile(user: User) -> AnyPublisher<LoginModel, Error> {
        let endPoint = Endpoint.updateProfile
        let params = [
            "name": user.name,
            "email": user.email,
            "user_selected_type": user.user_selected_type,
            "address": user.address,
            "dob": user.dob,
            "lat": user.lat,
            "lng": user.lng
        ]
        return networkManager.request(type: LoginModel.self, url: endPoint.url, httpMethod: .POST, headers: endPoint.headers, parameters: params)
    }
    
    func updateAttachmentFiles(params: [String: String]?, files: [Media]) -> AnyPublisher<LoginModel, Error> {
        let endPoint = Endpoint.updateProfile

        return networkManager.mutlipartResuest(type: LoginModel.self, url: endPoint.url, headers: endPoint.headers, parameters: params, media: files)
    }

    
}
