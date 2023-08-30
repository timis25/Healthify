//
//  DateFormatter.swift
//  ProjectOne
//
//  Created by Timur Israilov on 30/08/23.
//

import Foundation

extension Date {
    func toDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: self)
    }
}
