//
//  FavorBookingModel.swift
//  The Favour
//
//  Created by Atta khan on 30/07/2023.
//

import Foundation

enum ButtonStatus: String, Decodable {
    case pending = "pending"
    case inProgress = "in-progress"
    case accepted = "accepted"
    case rejected = "rejected"
    case completed = "completed"
    case buyer_approved = "buyer_approved"
}

struct FavorBookedModel : Decodable {
    let message : String?
    let error : Bool?
    let code : Int?
    let data : PaymentDataResult?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case error = "error"
        case code = "code"
        case data = "data"
    }
}





struct FavorBookingModel : Decodable {
    let message : String?
    let error : Bool?
    let code : Int?
    let total : Int?
    let has_pages : Bool?
    let current_page : Int?
    let last_page : Int?
    let data : [BookingData]?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case error = "error"
        case code = "code"
        case total = "total"
        case has_pages = "has_pages"
        case current_page = "current_page"
        case last_page = "last_page"
        case data = "data"
    }
}


struct PaymentDataResult: Codable {
    let booking_id: Int
    let paymentIntent: String
    let ephemeralKey: String
    let customer: String
    let publishableKey: String
}


struct FavorBookingDetailModel : Decodable {
    let message : String?
    let error : Bool?
    let code : Int?
    let total : Int?
    let has_pages : Bool?
    let current_page : Int?
    let last_page : Int?
    let data : BookingData?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case error = "error"
        case code = "code"
        case total = "total"
        case has_pages = "has_pages"
        case current_page = "current_page"
        case last_page = "last_page"
        case data = "data"
    }
}



struct BookingData : Decodable, Identifiable {
    let id : Int?
    let booking_id : Int?
    let time_id : String?
    let user_id : Int?
    let user_name : String?
    let revisions : String?
    let profile_photo: String?
    let total_price : Int?
    let details : String?
    let lat : Double?
    let lng : Double?
    var status : ButtonStatus?
    let favor_date: String?
    let favor_time: String?
    let address: String?
    let seller_user_id : Int?
    let favor_id : Int?
    let favor_details : Favor_details?
    let booking_lifecycle: [BookingList]?
    let review: Reviews?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case booking_id = "booking_id"
        case time_id = "time_id"
        case user_id = "user_id"
        case user_name = "user_name"
        case revisions = "revisions"
        case profile_photo = "profile_photo"
        case total_price = "total_price"
        case details = "details"
        case lat = "lat"
        case lng = "lng"
        case status
        case favor_date = "favor_date"
        case favor_time = "favor_time"
        case address = "address"
        case seller_user_id = "seller_user_id"
        case favor_id = "favor_id"
        case favor_details = "favor_details"
        case booking_lifecycle = "booking_lifecycle"
        case review = "review"
    }

}
struct Favor_details : Codable {
    let id : Int?
    let time_id : String?
    let user_id : String?
    let title : String?
    let category_id : String?
    let category : String?
    let service_type_id : String?
    let service_type : String?
    let placement : String?
    let delivery_date_time : String?
    let revisions : String?
    let price : String?
    let extra_service : String?
    let extra_service_price : String?
    let fast_delivery : String?
    let fast_delivery_price : String?
    let shipping_address : String?
    let total_price : String?
    let status : String?
    let active : String?
    let details : String?
    let order_date : String?
    let payment : String?
    let mode_of_payment : String?
    let resolution_comments : String?
    let created_at : String?
    let created_by_id : String?
    let created_by_name : String?
    let created_by_scrm : String?
    let updated_at : String?
    let updated_by_id : String?
    let updated_by_name : String?
    let is_tag_ticket : String?
    let tag_category : String?
    let tag_name : String?
    let lat : String?
    let lng : String?
    let address : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case time_id = "time_id"
        case user_id = "user_id"
        case title = "title"
        case category_id = "category_id"
        case category = "category"
        case service_type_id = "service_type_id"
        case service_type = "service_type"
        case placement = "placement"
        case delivery_date_time = "delivery_date_time"
        case revisions = "revisions"
        case price = "price"
        case extra_service = "extra_service"
        case extra_service_price = "extra_service_price"
        case fast_delivery = "fast_delivery"
        case fast_delivery_price = "fast_delivery_price"
        case shipping_address = "shipping_address"
        case total_price = "total_price"
        case status = "status"
        case active = "active"
        case details = "details"
        case order_date = "order_date"
        case payment = "payment"
        case mode_of_payment = "mode_of_payment"
        case resolution_comments = "resolution_comments"
        case created_at = "created_at"
        case created_by_id = "created_by_id"
        case created_by_name = "created_by_name"
        case created_by_scrm = "created_by_scrm"
        case updated_at = "updated_at"
        case updated_by_id = "updated_by_id"
        case updated_by_name = "updated_by_name"
        case is_tag_ticket = "is_tag_ticket"
        case tag_category = "tag_category"
        case tag_name = "tag_name"
        case lat = "lat"
        case lng = "lng"
        case address = "address"
    }


}

struct BookingList : Codable {
    let id : Int?
    let favor_id : String?
    let time_id : String?
    let user_id : String?
    let log_created_by_type : String?
    let status : String?
    let active : String?
    let details : String?
    let mode_of_payment : String?
    let notifiction_sent : String?
    let notification_user_id : String?
    let sent_at : String?
    let booking_id : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case favor_id = "favor_id"
        case time_id = "time_id"
        case user_id = "user_id"
        case log_created_by_type = "log_created_by_type"
        case status = "status"
        case active = "active"
        case details = "details"
        case mode_of_payment = "mode_of_payment"
        case notifiction_sent = "notifiction_sent"
        case notification_user_id = "notification_user_id"
        case sent_at = "sent_at"
        case booking_id = "booking_id"
    }
}


struct StripePaymentResult: Codable {
    let message: String
    let error: Bool
    let code: Int
    let data: PaymentData

    struct PaymentData: Codable {
        let result: PaymentResult

        struct PaymentResult: Codable {
            let paymentIntent: String
            let ephemeralKey: String
            let customer: String
            let publishableKey: String
        }
    }
}
struct UpdatePayemntResponseModel : Codable {
    let message : String?
    let error : Bool?
    let code : Int?
    let data : PaymentDataModel?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case error = "error"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        error = try values.decodeIfPresent(Bool.self, forKey: .error)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        data = try values.decodeIfPresent(PaymentDataModel.self, forKey: .data)
    }

}
struct PaymentDataModel : Codable {
    let id : Int?
    let time_id : String?
    let seller_user_id : String?
    let seller_user_name : String?
    let user_id : String?
    let user_name : String?
    let favor_date : String?
    let favor_time : String?
    let revisions : String?
    let price : String?
    let total_price : String?
    let status : String?
    let active : String?
    let details : String?
    let payment : String?
    let mode_of_payment : String?
    let resolution_comments : String?
    let created_at : String?
    let created_by_id : String?
    let created_by_name : String?
    let updated_at : String?
    let updated_by_id : Int?
    let updated_by_name : String?
    let lat : String?
    let lng : String?
    let address : String?
    let favor_id : String?
    let currency : String?
    let payment_status : String?
    let paymentIntent : String?
    let ephemeralKey : String?
    let customer : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case time_id = "time_id"
        case seller_user_id = "seller_user_id"
        case seller_user_name = "seller_user_name"
        case user_id = "user_id"
        case user_name = "user_name"
        case favor_date = "favor_date"
        case favor_time = "favor_time"
        case revisions = "revisions"
        case price = "price"
        case total_price = "total_price"
        case status = "status"
        case active = "active"
        case details = "details"
        case payment = "payment"
        case mode_of_payment = "mode_of_payment"
        case resolution_comments = "resolution_comments"
        case created_at = "created_at"
        case created_by_id = "created_by_id"
        case created_by_name = "created_by_name"
        case updated_at = "updated_at"
        case updated_by_id = "updated_by_id"
        case updated_by_name = "updated_by_name"
        case lat = "lat"
        case lng = "lng"
        case address = "address"
        case favor_id = "favor_id"
        case currency = "currency"
        case payment_status = "payment_status"
        case paymentIntent = "paymentIntent"
        case ephemeralKey = "ephemeralKey"
        case customer = "customer"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        time_id = try values.decodeIfPresent(String.self, forKey: .time_id)
        seller_user_id = try values.decodeIfPresent(String.self, forKey: .seller_user_id)
        seller_user_name = try values.decodeIfPresent(String.self, forKey: .seller_user_name)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        user_name = try values.decodeIfPresent(String.self, forKey: .user_name)
        favor_date = try values.decodeIfPresent(String.self, forKey: .favor_date)
        favor_time = try values.decodeIfPresent(String.self, forKey: .favor_time)
        revisions = try values.decodeIfPresent(String.self, forKey: .revisions)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        total_price = try values.decodeIfPresent(String.self, forKey: .total_price)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        active = try values.decodeIfPresent(String.self, forKey: .active)
        details = try values.decodeIfPresent(String.self, forKey: .details)
        payment = try values.decodeIfPresent(String.self, forKey: .payment)
        mode_of_payment = try values.decodeIfPresent(String.self, forKey: .mode_of_payment)
        resolution_comments = try values.decodeIfPresent(String.self, forKey: .resolution_comments)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
        created_by_name = try values.decodeIfPresent(String.self, forKey: .created_by_name)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        updated_by_id = try values.decodeIfPresent(Int.self, forKey: .updated_by_id)
        updated_by_name = try values.decodeIfPresent(String.self, forKey: .updated_by_name)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lng = try values.decodeIfPresent(String.self, forKey: .lng)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        favor_id = try values.decodeIfPresent(String.self, forKey: .favor_id)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
        paymentIntent = try values.decodeIfPresent(String.self, forKey: .paymentIntent)
        ephemeralKey = try values.decodeIfPresent(String.self, forKey: .ephemeralKey)
        customer = try values.decodeIfPresent(String.self, forKey: .customer)
    }

}
