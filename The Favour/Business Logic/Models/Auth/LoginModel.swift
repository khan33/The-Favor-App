//
//  LoginModel.swift
//  The Favour
//
//  Created by Atta khan on 24/05/2023.
//

import Foundation

struct LoginModel: Decodable {
    let message: String?
    let error: Bool?
    let code: Int
    let error_messages: String?
    let data: Login?
}


struct Login: Decodable {
    let token: String?
    let user: User?
    var new_register: Bool? = false
    
    private enum CodingKeys: String, CodingKey {
        case token = "token"
        case user = "user_details"
        case new_register = "new_register"
    }
}

struct User: Codable {
    let id: Int?
    let first_name: String?
    let last_name: String?
    let contact_number: String?
    let email: String?
    let name: String?
    let user_type: String?
    let address: String?
    let dob: String?
    let id_card: String?
    let user_types: String?
    let user_selected_type: String?
    let lat: String?
    let lng: String?
    let profile_photo: String?
    let user_status: String?
    let file_back_url: String?
    let file_front_url: String?
    let file_type: String?
    let login_type: String?
    let token: String?
}


struct ForgotPasswordModel: Decodable {
    let message: String?
    let error: Bool?
    let code: Int
    let error_messages: String?
    let data: String?
}

struct ResetPasswordModel: Decodable {
    let message: String?
    let error: Bool?
    let code: Int
    let error_messages: String?
}
