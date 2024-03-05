//
//  Data+Extension.swift
//  The Favour
//
//  Created by Atta khan on 27/07/2023.
//

import Foundation

extension Data {
   mutating func append(_ string: String) {
      if let data = string.data(using: .utf8) {
         append(data)
         print("data======>>>",data)
      }
   }
}
