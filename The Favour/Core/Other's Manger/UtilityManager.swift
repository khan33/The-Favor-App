//
//  UtilityManager.swift
//  The Favour
//
//  Created by Atta khan on 20/07/2023.
//

import Foundation
import SwiftUI

class UtilityManager {
    
    static let shared = UtilityManager()
    private init() {}

    
    func getTimeAgoString(from dateString: String) -> String {
        //Aug 13, 2023 9:04 PM
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy hh:mm a"
        //"yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: dateString) else {
            return "Invalid Date"
        }

        let now = Date()
        let components = Calendar.current.dateComponents([.weekOfYear, .day, .hour, .minute, .second], from: date, to: now)

        if let weeks = components.weekOfYear, weeks > 0 {
            return "\(weeks) week\(weeks == 1 ? "" : "s") ago"
        } else if let days = components.day, days > 0 {
            return "\(days) day\(days == 1 ? "" : "s") ago"
        } else if let hours = components.hour, hours > 0 {
            return "\(hours) hour\(hours == 1 ? "" : "s") ago"
        } else if let minutes = components.minute, minutes > 0 {
            return "\(minutes) minute\(minutes == 1 ? "" : "s") ago"
        } else if let seconds = components.second, seconds > 0 {
            return "\(seconds) second\(seconds == 1 ? "" : "s") ago"
        } else {
            return "Just now"
        }
    }
    
    func convertDateTime(dateStr: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        // Parse the server's date string into a Date object
        guard let serverDate = dateFormatter.date(from: dateStr) else {
            return "Invalid Date"
        }

        // Set the desired generic date format
        dateFormatter.dateFormat = "MMM d, yyyy hh:mm a"

        // Format the date into the desired generic form
        return dateFormatter.string(from: serverDate)
    }
    
    
    func buttonText(for state: ButtonStatus) -> String {
        switch state {
            case .pending:
                return "Pending"
            case .inProgress:
                return "In Progress"
            case .accepted:
                return "Accepted"
            case .rejected:
                return "Recjected"
            case .completed:
                return "Completed"
            case .buyer_approved:
                return "Approved"
        }
    }
    
    
    func buttonColor(for state: ButtonStatus) -> Color {
        switch state {
            case .pending:
                return Color.blue
            case .inProgress:
                return Color.green
            case .accepted:
                return Color.appPrimaryColor
            case .rejected:
                return Color.red
            case .completed:
                return Color.green
        case .buyer_approved:
            return Color.green
        }
    }
    
    
}
