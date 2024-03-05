//
//  NetworkConstants.swift
//  The Favour
//
//  Created by Atta khan on 24/05/2023.
//

import Foundation

struct NetworkConstants {
    static let scheme = "https"
    static let host = "aalphahub.com"
    static let path = "/favorapp/public/api/v1/"
    
    static let loginService = "login"
    static let register = "register"
    static let socialLogin = "loginWithSocial"
    static let logout = "logout"
    static let resetPassword = "reset-password"
    static let forgotPassword = "forget-password"
    
    
    
    static let getFavor = "favors"
    static let getFavorDetailById = "favors/details?favor_id=10"
    
    
    static let favorBookingByUser = "favors/bookings"
    static let getBookingDetail = "favors/bookings/details"
    static let favorBooking = "favors/bookings/store"
    static let updateBookingFavor = "favors/bookings/update"
    static let deleteBookingFavor = "favors/bookings/delete"
    static let bookingApproved = "favors/bookings/approved_complete"
    static let addRating = "favors/bookings/add_rating"

    
    // seller api's
    
    static let seller_booking = "favors/seller_booking"
    static let seller_booking_details = "favors/seller_booking/details"
    static let seller_booking_action = "favors/seller_booking/action"
    static let seller_booking_start = "favors/seller_booking/start_booking"
    static let seller_complete_booking = "favors/seller_booking/complete_booking"

    
    
    
    static let getServices = "services"
    static let getUserDetail = "user"
    static let updateUserProfile = "user"
    
    
    static let favorUpdate = "favors/update"
    static let favorPost = "favors/store"
    static let getUserFavor = "favors/user"
    static let deleteFavor = "favors/delete"
    
    
    
    // Custom Favors
    
    static let customFavorListing = "custom_favors/user"
    static let saveCustomFavor = "custom_favors/store"
    static let udpateCustomFavor = "custom_favors/update"
    static let deleteCustomFavor = "custom_favors/delete"
    
    // Accept Custom Favor
    
    static let acceptCustomFavorByUser = "custom_favors/bookings/offer"
    static let payemnt_update = "favors/bookings/payment_update"

    
}
