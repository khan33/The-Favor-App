//
//  NetworkManager.swift
//  The Favour
//
//  Created by Atta khan on 24/05/2023.
//
import Foundation
import Combine
import SwiftUI

protocol NetworkManagerProtocol: AnyObject {
    typealias Headers = [String: Any]
    typealias Parameters = [String: Any]
    func request<T>(type: T.Type, url: URL, httpMethod: HTTPMethod, headers: Headers, parameters: Parameters?) -> AnyPublisher<T, Error> where T: Decodable
    
    func mutlipartResuest<T>(type: T.Type, url: URL, headers: Headers, parameters: Parameters?, media: [Media]?) -> AnyPublisher<T, Error> where T: Decodable

}

final class NetworkManager: NetworkManagerProtocol {
    private var cancellables = Set<AnyCancellable>()
    func request<T>(type: T.Type, url: URL, httpMethod: HTTPMethod, headers: Headers, parameters: Parameters?) -> AnyPublisher<T, Error> where T : Decodable {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        
        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let params = parameters {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        }
        
        print("===================Request Body & URL ===================")
        print(urlRequest)
        print(headers)
        print(parameters)
        print("======================================")
        
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            //.map(\.data)
            .tryMap { element -> Data in
                let status = element.response as? HTTPURLResponse
                //httpResponse.statusCode == 200
                guard let httpResponse = element.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                if let dataString = String(data: element.data, encoding: .utf8) {
                    print("got dataString and URL \n\(urlRequest) /n ======== /n: \n\(dataString)")
                }
                    return element.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
    func mutlipartResuest<T>(type: T.Type, url: URL, headers: Headers, parameters: Parameters?, media: [Media]?) -> AnyPublisher<T, Error> where T: Decodable {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        //create boundary
        let boundary = generateBoundary()
        //set content type
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
         if let token = KeychainManager.getAuthToken() {
             request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
         }
        //call createDataBody method
        let dataBody = createDataBody(withParameters: parameters, media: media, boundary: boundary)
        request.httpBody = dataBody
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()

    }
    
    func generateBoundary() -> String {
       return "Boundary-\(NSUUID().uuidString)"
    }
    
    func createDataBody(withParameters params: [String: Any]?, media: [Media]?, boundary: String) -> Data {
       let lineBreak = "\r\n"
       var body = Data()
       if let parameters = params {
          for (key, value) in parameters {
             body.append("--\(boundary + lineBreak)")
             body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
             body.append("\(value as! String + lineBreak)")
          }
       }
       if let media = media {
          for photo in media {
             body.append("--\(boundary + lineBreak)")
             body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
             body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
             body.append(photo.data)
             body.append(lineBreak)
          }
       }
       body.append("--\(boundary)--\(lineBreak)")
       return body
    }
    
}
