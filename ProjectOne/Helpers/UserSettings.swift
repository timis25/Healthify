//
//  UserSettings.swift
//  ProjectOne
//
//  Created by Timur Israilov on 19/09/21.
//
import Foundation

class UserSettings {
    // MARK: - Onboarding

    static func isShowMain() -> Bool {
        return UserDefaults.standard.bool(forKey: "isShowMain")
    }

    static func setIsShowMain(_ isShow: Bool) {
        UserDefaults.standard.set(isShow, forKey: "isShowMain")
    }

    static func isShowStartProfileSettings() -> Bool {
        return UserDefaults.standard.bool(forKey: "isShowProfile")
    }

    static func setIsShowStartProfileSettings(_ isShow: Bool) {
        UserDefaults.standard.set(isShow, forKey: "isShowProfile")
    }

    static func isThisDay() -> Bool {
        let date = UserDefaults.standard.object(forKey: "dayToday") as? Date ?? Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let lastDate = dateFormatter.string(from: date)
        let nowDate = dateFormatter.string(from: Date())
        return lastDate == nowDate
    }

    static func setNowDay(_ date: Date) {
        UserDefaults.standard.set(date, forKey: "dayToday")
    }
}
