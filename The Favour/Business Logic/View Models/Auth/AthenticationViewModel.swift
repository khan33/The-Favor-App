//
//  AthenticationViewModel.swift
//  The Favour
//
//  Created by Atta khan on 24/05/2023.
//

import Foundation
import Combine
import AuthenticationServices
import Firebase
import CryptoKit
import CoreLocation

class AthenticationViewModel: ObservableObject {
    
    @Published var alertType: AlertType?
    private let authenticationManager: AthenticationManager = AthenticationManager()
    let phoneRegexPattern = #"^\d{11}$"#
    let dateRegexPattern = #"^(0[1-9]|1[0-2])/(0[1-9]|1\d|2\d|3[01])/\d{4}$"#
//    +1 (443) 354-2274
    private var cancellables = Set<AnyCancellable>()
    @Published var loginIsValid = false
    @Published var signupIsValid = false
    @Published var showMainTabView: Bool = false
    @Published var nonce = ""
    @Published var code: String = ""
#if targetEnvironment(simulator)
    @Published var email: String = "buyer@gmail.com"
    @Published var password: String = "admin123"
#else
    @Published var email: String = ""
    @Published var password: String = ""
#endif

    @Published var confirmPassord: String = ""
    @Published var fullName: String = ""
    @Published var dateOfBirth: String = ""
    @Published var phoneNumber: String = ""
    @Published var showUserRoleView: Bool = false
    @Published var new_register: Bool = false
    @Published var isUpdate: Bool = false

    @Published var selectedPickDate = Date() {
        didSet {
            updatePickDatetime()
        }
    }

    
    @Published private(set) var isEmailValid: Bool = false
    @Published private(set) var isResetPasswordFormValid: Bool = false

    @Published var shouldShowLoader: Bool = false
    @Published var errorMessage: String = ""
    @Published var showMessage: Bool = false
    @Published var user: User?

    private var locationManager = LocationManager()
    private var toastTimer: AnyCancellable?

    var moveToNextScreen: ((Int) -> Void)?
    var token: String?
    var userType: String?
    
    init() {
        isLoginFormValidPublisher
          .receive(on: RunLoop.main)
          .assign(to: \.loginIsValid, on: self)
          .store(in: &cancellables)
        isSignupFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.signupIsValid, on: self)
            .store(in: &cancellables)
        userType = PrefsManager.shared.favorType
        
        isUserEmailValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isEmailValid, on: self)
            .store(in: &cancellables)

        isResetPasswordValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isResetPasswordFormValid, on: self)
            .store(in: &cancellables)
        

        
      }
    
    private func updatePickDatetime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateOfBirth = dateFormatter.string(from: selectedPickDate)
    }
    
    func showToast(with message: String, showToas: Bool) {
        errorMessage = message
        showMessage = true
        
        DispatchQueue.main.async {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.showMessage = false
            }
        }
    }
    
    
    func performLogin() {

        shouldShowLoader = true
        authenticationManager.login(email: email, password: password, fcm_token: PrefsManager.shared.fcmKey)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    self?.errorMessage = "Invalid Email or Password."
                    print("Couldn't login: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                self?.handleLoignResponse(model)
                self?.loginWithFirebase()
            }
            .store(in: &cancellables)
    }
    
    func loginWithFirebase() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil { print(error?.localizedDescription ?? "") }
            else { print("firebase login successfully....")}
        }
    }
    
    func saveUserType(_ type: String) {
        PrefsManager.shared.favorType = type
    }
    
    

    func performSignup(address: String, lat: String, lng: String) {
        shouldShowLoader = true
        authenticationManager.signup(email: email, password: password, name: fullName, user_type: "buyer", contact_number: phoneNumber, address: address, dob: dateOfBirth, id_card: "3241", lat: lat, lng: lng)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    self?.errorMessage = "There are some thing missing. please try again!"
                    print("Couldn't login: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                self?.handleLoignResponse(model)
            }
            .store(in: &cancellables)
    }
    
    private func moveToMainTabView() {
        shouldShowLoader = false
        showMainTabView = true
    }
    
    
    func logout() {
        shouldShowLoader = true
        authenticationManager.logout(token: "")
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    self?.errorMessage = "Provided mobile number is not correct"
                    print("Couldn't login: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
//                self?.moveToNextScreen?(model.data.firstTime ?? 0)
                print(model)
            }
            .store(in: &cancellables)
    }
    
    func resetPassword(email: String) {
        shouldShowLoader = true
        authenticationManager.resetPassword(email: email, password: password, token: code, password_confirmation: confirmPassord)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    self?.errorMessage = "Provided mobile number is not correct"
                    print("Couldn't login: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                if model.error == false {
                    self?.showMainTabView = true
                } else {
                    self?.alertType = .error
                    self?.errorMessage = model.error_messages ?? "There are something went worng please try again."
                }
            }
            .store(in: &cancellables)
    }
    
    func forgotPassword() {
        shouldShowLoader = true
        authenticationManager.forgotPassword(email: email)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    self?.errorMessage = "Provided mobile number is not correct"
                    print("Couldn't login: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
//                self?.moveToNextScreen?(model.data.firstTime ?? 0)
                print(model.error)
                if model.error == false {
                    self?.showMainTabView = true
                } else {
                    self?.alertType = .error
                    self?.errorMessage = "Failed to send password reset email"
                }

                
                
            }
            .store(in: &cancellables)
    }
    
    
    func getUser() {
        shouldShowLoader = true
        authenticationManager.forgotPassword(email: email)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    self?.errorMessage = "Provided mobile number is not correct"
                    print("Couldn't login: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
//                self?.moveToNextScreen?(model.data.firstTime ?? 0)
                print(model)
            }
            .store(in: &cancellables)
    }
    
    
    
    func updateProfile() {
        let id = String(self.user?.id ?? 0)
        shouldShowLoader = true
        authenticationManager.updateUserProfile(id: id, name: fullName, contact_number: phoneNumber, address: locationManager.currentAddress, dob: dateOfBirth, lat: String(locationManager.latitude), lng: String(locationManager.longitude))
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    self?.errorMessage = "Provided mobile number is not correct"
                    print("Couldn't login: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                print(model)
                if let error = model.error {
                    self?.showToast(with: model.message ?? "", showToas: error)
                }
            }
            .store(in: &cancellables)
    }
    
    
    func updateUserProfileAttachment(_ params: [String: String]?,  _ media: [Media]) {
        shouldShowLoader = true
        authenticationManager.updateAttachmentFiles(params: params, files: media)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    self?.errorMessage = "Provided mobile number is not correct"
                    print("Couldn't login: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                print(model)
                self?.handleLoignResponse(model)
            }
            .store(in: &cancellables)
    }
    
    
    
    func handleLoignResponse(_ model: LoginModel) {
        if let error = model.error, error == true {
            self.showToast(with: model.error_messages ?? "", showToas: error)
        } else {
            
            if let error  = model.error, error == false {
                if let data = model.data {
                    if let token = data.token {
                        KeychainManager.saveAuthToken(token)
                    }
                    if let userObject = data.user {
                        let encoder = JSONEncoder()
                        if let encoded = try? encoder.encode(userObject) {
                            UserDefaults.standard.set(encoded, forKey: "currentUser")
                        }
                    }
                    
                    self.moveToMainTabView()

//                        self.userType = type
//                        self.saveUserType(type)
                    
                    self.new_register = data.new_register ?? false
                    PrefsManager.shared.username = data.user?.name ?? "Test User"
                    
                }
            } else {
                shouldShowLoader = false
                showUserRoleView = true
            }
        }
    }
    
    func storeUser(_ user: User) {
        self.user = user
    }
    
    func retriveUser() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "currentUser"),
           let storedUser = try? decoder.decode(User.self, from: data) {
            self.user = storedUser
            self.fullName = self.user?.name ?? ""
            self.email = self.user?.email ?? ""
            self.dateOfBirth = self.user?.dob ?? ""
            self.phoneNumber = self.user?.contact_number ?? ""
        }
    }

    
   
}

//MARK: LOGIN WITH SOCIAL

extension AthenticationViewModel {
    func performSocialLogin(name: String, email: String, token: String, login_type: String) {
        shouldShowLoader = true
        authenticationManager.loginWithSocial(email: email, token: token, name: name, login_type: login_type)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.shouldShowLoader = false
                    self?.errorMessage = "Provided mobile number is not correct"
                    print("Couldn't login: \(error)")
                case .finished:
                    self?.shouldShowLoader = false
                    break
                }
            } receiveValue: { [weak self] model in
                self?.handleLoignResponse(model)
            }
            .store(in: &cancellables)
    }
    
    enum AlertType: Identifiable {
        case success
        case error
        
        var id: String {
            // Provide a unique identifier for each case
            switch self {
            case .success:
                return "success"
            case .error:
                return "error"
            }
        }
    }

}


private extension AthenticationViewModel {
    
    var isUserEmailValidPublisher: AnyPublisher<Bool, Never> {
        $email
            .map { email in
                let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
                return emailPredicate.evaluate(with: email)
            }
            .eraseToAnyPublisher()
    }
        
    var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        $password
              .map { password in
                  return password.count >= 5
              }
              .eraseToAnyPublisher()
      }
    

    var isConfirmPasswordValidPublisher: AnyPublisher<Bool, Never> {
        Publishers
            .CombineLatest($password, $confirmPassord)
            .map { pass, confirmPass in
                pass == confirmPass
            }
            .eraseToAnyPublisher()
      }
    
    var isTokenValidPublisher: AnyPublisher<Bool, Never> {
        $code
              .map { code in
                  return code.count >= 6
              }
              .eraseToAnyPublisher()
      }
    
    var isfullNameValidPublisher: AnyPublisher<Bool, Never> {
        $fullName
            .map { name in
                return name.count >= 4
            }
            .eraseToAnyPublisher()
    }
    
    var isValidMobile: AnyPublisher<Bool, Never> {
        $phoneNumber
            .map { phoneNumber in
                let range = NSRange(location: 0, length: phoneNumber.utf16.count)
                let regex = try! NSRegularExpression(pattern: self.phoneRegexPattern)
                let matches = regex.numberOfMatches(in: phoneNumber, options: [], range: range)
                return matches == 1
            }
            .eraseToAnyPublisher()
    }
    
    var dateValidationPublisher: AnyPublisher<Bool, Never> {
        $dateOfBirth
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { dateOfBirth in
                let range = NSRange(location: 0, length: dateOfBirth.utf16.count)
                let regex = try! NSRegularExpression(pattern: self.dateRegexPattern)
                let matches = regex.numberOfMatches(in: dateOfBirth, options: [], range: range)
                return matches == 1
            }
            .eraseToAnyPublisher()
    }
    
    
    
    var isLoginFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(
          isUserEmailValidPublisher,
          isPasswordValidPublisher)
          .map { isEmailValid, isPasswordValid in
              return isEmailValid && isPasswordValid
          }
          .eraseToAnyPublisher()
      }
    
    
    var isSignupFormValidPublisher: AnyPublisher<Bool, Never> {
        
        
        Publishers.CombineLatest3(
          isUserEmailValidPublisher,
          isPasswordValidPublisher,
          isfullNameValidPublisher
          )
          .map { isUserEmailValid, isPasswordValid, isValidFullNameValid  in
              return isUserEmailValid && isPasswordValid && isValidFullNameValid
          }
          .eraseToAnyPublisher()
      }
    
    
    
    var isResetPasswordValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(
          isPasswordValidPublisher,
          isConfirmPasswordValidPublisher,
          isTokenValidPublisher
          )
        .map { isPasswordValid, isConfirmPasswordValid ,isTokenValid in
            return isPasswordValid && isTokenValid && isConfirmPasswordValid
        }
        .eraseToAnyPublisher()
      }

}

extension AthenticationViewModel {
    func appleAuthentication(credential: ASAuthorizationAppleIDCredential) {
        // getting token
        guard let token = credential.identityToken else {
            print("Error with Firebase... ")
            return
        }
        
        
        guard let tokenString = String(data: token, encoding: .utf8) else {
            print("Error with token")
            return
        }
        let credential = OAuthProvider.appleCredential(withIDToken: tokenString, rawNonce: nonce, fullName: credential.fullName)
        
        // Sign in with Firebase.
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error {
                print(error.localizedDescription)
                return
            }
            print(authResult?.user.uid)
            
            if let data = authResult?.user {
                self.performSocialLogin(name: data.displayName ?? "Apple User", email: data.email ?? "", token: data.uid ?? "", login_type: "Google")
            }

        }
    }
}



// helper for Apple login with firebase

func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  var randomBytes = [UInt8](repeating: 0, count: length)
  let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
  if errorCode != errSecSuccess {
    fatalError(
      "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
    )
  }

  let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

  let nonce = randomBytes.map { byte in
    // Pick a random character from the set, wrapping around if needed.
    charset[Int(byte) % charset.count]
  }

  return String(nonce)
}

    
func sha256(_ input: String) -> String {
  let inputData = Data(input.utf8)
  let hashedData = SHA256.hash(data: inputData)
  let hashString = hashedData.compactMap {
    String(format: "%02x", $0)
  }.joined()

  return hashString
}
