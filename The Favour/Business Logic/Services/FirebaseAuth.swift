//
//  FirebaseAuth.swift
//  The Favour
//
//  Created by Atta khan on 14/07/2023.
//

import Foundation
import AuthenticationServices
import FirebaseAuth
import GoogleSignIn
import Firebase



struct FirebaseAuth {
    static let shared = FirebaseAuth()
    typealias completionHandler = (Result<AuthDataResult?, Error>) -> Void

    
    func signInWithGoogle(presenting: UIViewController, completion: @escaping completionHandler) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: presenting) { result, error in
            guard error == nil else {
                completion(.failure(error as! Error))
                return
            }
            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                completion(.failure(error as! Error))
                return
            }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { result , error in
                if let error = error {
                    completion(.failure(error as! Error))
                    return
                }
                
               completion(.success(result))
            }
        

         
        }
    }
}
