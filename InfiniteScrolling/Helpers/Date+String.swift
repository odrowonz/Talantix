//
//  Date+String.swift
//  MyHabits
//
//  Created by Andrey Antipov on 28.11.2020.
//  Copyright © 2020 Andrey Antipov. All rights reserved.
//
import UIKit

extension Date {
    /// Date textual representation.
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.doesRelativeDateFormatting = true
        dateFormatter.locale = Locale(identifier: "en")
        //dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    /// Time textual representation.
    func timeToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }

    /// Textual representation of date and time.
    func datetimeToString() -> String {
        return dateToString() + " " + timeToString()
    }

}
