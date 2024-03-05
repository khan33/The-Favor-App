//
//  BookingViewModel.swift
//  The Favour
//
//  Created by Atta khan on 30/07/2023.
//

import Foundation
import StripePaymentSheet
import SwiftUI
import Combine


final class BookingViewModel: ObservableObject {
    private let favorBookingManager: FavorBookingManager = FavorBookingManager()
    private var cancellables = Set<AnyCancellable>()
    @Published var shouldShowLoader: Bool = false
    
    @Published var bookingFavor: [BookingData]?
    @Published var favorPrice: String = ""
    @Published var date: String = ""
    @Published var time: String = ""
    @Published var details: String = ""
    @Published var lat: Double = 0.0
    @Published var lng: Double = 0.0
    @Published var address: String = ""
    @Published var newLat: Double = 0.0
    @Published var isValidPost = false
    @Published var currentDate: Date = Date()
    @Published var isAlertShow: Bool = false
    @Published var alertMsg: String = ""
    @Published var sellerBookingRequest: [BookingData] = []
    @Published var booking_data: BookingData?
    @Published var isShowPopup: Bool = false
    @Published var popup_message: String = ""
    @Published var detail_page: Bool = false
    @Published var show_rating_popup: Bool = false
    private var locationManager = LocationManager()
    
    @Published var paymentSheet: PaymentSheet?
    @Published var paymentResult: PaymentSheetResult?
    @Published var isSuccessPayment: Bool = false
    @Published var isErrorPayment: Bool = false
    @Published var booking_id: Int?
    @Published var bookingPayment: PaymentDataModel?

    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter.string(from: currentDate)
    }
    
    init() {
        isFavorBookValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValidPost, on: self)
            .store(in: &cancellables)

    }
    
    
    func getFavorBooking() {
        shouldShowLoader = true
        favorBookingManager.getUserBookingFavorList()
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    print("Couldn't get favor booking: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                if let data = model.data {
                    self?.bookingFavor = data
                }
                
            }
            .store(in: &cancellables)
    }
    
    
    func handleStripeResponse1(_ result : StripePaymentResult) {
        DispatchQueue.main.async {
//                        self.paymentResult = result
            let customerId = result.data.result.customer
            let customerEphemeralKeySecret = result.data.result.ephemeralKey
            let paymentIntentClientSecret = result.data.result.paymentIntent
            let publishableKey = result.data.result.publishableKey

            
            print("customer id = \(customerId)")
            
            STPAPIClient.shared.publishableKey = publishableKey

            // MARK: Create a PaymentSheet instance
            var configuration = PaymentSheet.Configuration()

            configuration.merchantDisplayName = "The Favor App"
//            configuration.applePay = .init(
//                merchantId: "com.foo.example", merchantCountryCode: "US")
            configuration.customer = .init(
                id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
            configuration.returnURL = "payments-example://stripe-redirect"
            // Set allowsDelayedPaymentMethods to true if your business can handle payment methods that complete payment after a delay, like SEPA Debit and Sofort.
            configuration.allowsDelayedPaymentMethods = true
            DispatchQueue.main.async {
                self.paymentSheet = PaymentSheet(
                    paymentIntentClientSecret: paymentIntentClientSecret,
                    configuration: configuration)
            }
            
        }

    }

    
    func handleStripeResponse(_ result : PaymentDataResult) {
        DispatchQueue.main.async {
//                        self.paymentResult = result
//            let customerId = result.data.result.customer
//            let customerEphemeralKeySecret = result.data.result.ephemeralKey
//            let paymentIntentClientSecret = result.data.result.paymentIntent
//            let publishableKey = result.data.result.publishableKey

            let customerId = result.customer
            let customerEphemeralKeySecret = result.ephemeralKey
            let paymentIntentClientSecret = result.paymentIntent
            let publishableKey = result.publishableKey
            
            print("customer id = \(customerId)")
            
            STPAPIClient.shared.publishableKey = publishableKey

            // MARK: Create a PaymentSheet instance
            var configuration = PaymentSheet.Configuration()

            configuration.merchantDisplayName = "The Favor App"
//            configuration.applePay = .init(
//                merchantId: "com.foo.example", merchantCountryCode: "US")
            configuration.customer = .init(
                id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
            configuration.returnURL = "payments-example://stripe-redirect"
            // Set allowsDelayedPaymentMethods to true if your business can handle payment methods that complete payment after a delay, like SEPA Debit and Sofort.
            configuration.allowsDelayedPaymentMethods = true
            DispatchQueue.main.async {
                self.paymentSheet = PaymentSheet(
                    paymentIntentClientSecret: paymentIntentClientSecret,
                    configuration: configuration)
            }
            
        }

    }


    
    func newBookingFavor(id: String, completion: @escaping (Bool) -> Void) {
        shouldShowLoader = true
        
        let favor = BookingFavor(total_price: favorPrice, favor_date: formattedDate, favor_time: time, details: details, lat: String(locationManager.latitude), lng: String(locationManager.longitude), address: locationManager.currentAddress, favor_id: id)
        
        favorBookingManager.userAddBookingFavor(favor: favor)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    print("Couldn't save favor booking: \(error)")
//                    completion(false) // Pass false to indicate failure
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
//                self?.isAlertShow = true
                if let data = model.data {
                    self?.booking_id = data.booking_id
                    self?.handleStripeResponse(data)
                    completion(true)
                }
            }
            .store(in: &cancellables)
    }
    

    func onCompletion(result: PaymentSheetResult) {
        self.paymentResult = result
        switch self.paymentResult {
        case .completed:
            updatePaymentStatus(status: "success")
        case .canceled:
            updatePaymentStatus(status:"canceled")
        case .failed(let error):
            updatePaymentStatus(status:"canceled")
        case .none:
            isErrorPayment = true
        }
    }

    func updatePaymentStatus(status: String) {
        guard let id = booking_id else { return }
        favorBookingManager.bookingPaymentUpdate(bookingId: id, status: status)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    print("Couldn't udpate favor booking: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                if let data = model.data {
                    self?.bookingPayment = data
                    self?.isAlertShow = true
                    self?.alertMsg = model.message ?? ""
                }
                
            }
            .store(in: &cancellables)

    }

    
    
    
    func udpateBookingFavor(id: String) {
        shouldShowLoader = true
        
        let favor = BookingFavor(total_price: favorPrice, favor_date: date, favor_time: time, details: details, lat: String(lat), lng: String(lng), address: address, favor_id: id)
        
        favorBookingManager.userUpdateBookingFavor(favor: favor)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    print("Couldn't udpate favor booking: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                if let data = model.data {
                    self?.bookingFavor = data
                }
                
            }
            .store(in: &cancellables)
    }

    func deleteBookingFavor(id: Int) {
        shouldShowLoader = true
        favorBookingManager.userDeleteBookingFavor(bookingId: id, status: "deleted")
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    print("Couldn't udpate favor booking: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                if let data = model.data {
                    self?.bookingFavor = data
                }
                
            }
            .store(in: &cancellables)
    }

    func bookingApprovedByBuyer(bookingId: Int) {
        shouldShowLoader = true
        favorBookingManager.userBookingApproved(bookingId: bookingId, status: "")
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    print("Couldn't booking approved: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                if let data = model.error {
                    if data == false {
                        self?.booking_data?.status = ButtonStatus.buyer_approved
                        self?.show_rating_popup = true
                    }
                }
                
                
            }
            .store(in: &cancellables)

    }
    
    
    func addRatingToFavor(bookingId: String, comments: String, rating: String) {
        shouldShowLoader = true
        favorBookingManager.useraddRating(bookingId: bookingId, rating: rating, comments: comments)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    print("Couldn't Rate to booking: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                if let data = model.error, let message = model.message {
                    self?.show_rating_popup = false
                    
                    self?.isShowPopup = true
                    self?.popup_message = message


                }
                
            }
            .store(in: &cancellables)

    }
    
    
    
    func getFavorListBySeller(id: String) {
        shouldShowLoader = true
        favorBookingManager.getSellerBookingFavorList(favorId: id)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    print("Couldn't get favor list of seller booking: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                if let data = model.data {
                    self?.sellerBookingRequest = data
                }
                
            }
            .store(in: &cancellables)

    }

    func sellerActionOnBooking(bookingId: Int, status: ButtonStatus) {
        shouldShowLoader = true
        favorBookingManager.getSellerBookingAction(booking_id: bookingId, status: status.rawValue)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    print("Couldn't get favor list of seller booking: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                if let data = model.error, let message = model.message {
                    self?.isShowPopup = true
                    self?.popup_message = message
                    if data == false {
                        self?.booking_data?.status = status
                    }
                }
            }
            .store(in: &cancellables)

    }
    func sellerStartFavor(bookingId: Int) {
        shouldShowLoader = true
        favorBookingManager.getSellerBookingStart(booking_id: bookingId, lat: locationManager.latitude, lng: locationManager.longitude)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    print("Couldn't get favor list of seller booking: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                if let data = model.error, let message = model.message {
                    self?.isShowPopup = true
                    self?.popup_message = message
                    
                    if data == false {
                        self?.booking_data?.status = ButtonStatus.inProgress
                    }
                }
            }
            .store(in: &cancellables)

    }
    
    
    func sellerCompleteFavor(bookingId: Int) {
        shouldShowLoader = true
        favorBookingManager.getSellerBookingComplete(booking_id: bookingId, lat: locationManager.latitude, lng: locationManager.longitude)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    print("Couldn't get favor list of seller booking: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                if let data = model.error, let message = model.message {
                    self?.isShowPopup = true
                    self?.popup_message = message
                    
                    if data == false {
                        self?.booking_data?.status = ButtonStatus.completed
                    }
                }
            }
            .store(in: &cancellables)

    }

    
    func addRatingToFavor(bookingId: String, rating: Int, comments: String) {
        shouldShowLoader = true
        favorBookingManager.useraddRating(bookingId: bookingId, rating: String(rating), comments: comments)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    print("There are something went worng: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                print(model)
            }
            .store(in: &cancellables)

    }
    
//    add_rating
    
    func getFavorBookingById(bookingId: Int) {
        shouldShowLoader = true
        favorBookingManager.getSellerBookingDetailById(bookingId: bookingId)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    print("Couldn't get favor list of seller booking: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                if let data = model.data {
                    self?.booking_data = data
                    print(self?.booking_data?.status)
                }
                
            }
            .store(in: &cancellables)

    }

    
    
    

}
extension BookingViewModel {
    
    
    var isPriceValidPublisher: AnyPublisher<Bool, Never> {
        $favorPrice
            .map { title in
                return !title.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    var isDesValidPublisher: AnyPublisher<Bool, Never> {
        $details
            .map { desc in
                return !desc.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    
    var isFavorBookValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(
            isPriceValidPublisher,
            isDesValidPublisher)
          .map { isPriceValid, isDescValid in
              return isPriceValid && isDescValid
          }
          .eraseToAnyPublisher()
      }

    
}

enum BookingStaus: String {
    case pending = "Pending"
    case accpeted = "Accepted"
    case rejected = "Rejected"
    case completed = "Completed"
    case inProgress = "in_progress"


}
