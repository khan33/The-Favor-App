//
//  Media.swift
//  The Favour
//
//  Created by Atta khan on 27/07/2023.
//

import Foundation
import UIKit

struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "imagefile.jpg"
        guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
        self.data = data
    }
}


struct MultipartFormData {
    let name: String
    let value: String
}
