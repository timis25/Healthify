//
//  UserSettings.swift
//  ProjectOne
//
//  Created by Timur Israilov on 19/09/21.
//
import Foundation

final class UserSettings {
    // MARK: - Constants
    private enum Constants {
        static let isShowMainId: String = "com.userSettings.isShowMan"
        static let isShowProfileId: String = "com.userSettings.isShowProfile"
        static let dayTodayId: String = "com.userSettings.DayToday"
        static let widgetInfoId: String = "com.userSettings.DailyInfo"
        static let widgetUserDefautlsId: String = "group.timis.Healthtify.Widget"
    }

    // MARK: - Public static methods
    static func addDataToWidget(_ widgetData: WidgetModel) {
        let userDefaults = UserDefaults(suiteName: Constants.widgetUserDefautlsId)
        guard let data = try? JSONEncoder().encode(widgetData) else { return }
        userDefaults?.set(data, forKey: Constants.widgetInfoId)
    }

    static func getDataWidget() -> WidgetModel {
        let userDefaults = UserDefaults(suiteName: Constants.widgetUserDefautlsId)
        guard let data = userDefaults?.object(
            forKey: Constants.widgetInfoId
        ) as? Data
        else {
            return WidgetModel(todayProducts: [], dailyNutrition: NutritionModel())
        }
        guard let model = try? JSONDecoder().decode(
            WidgetModel.self,
            from: data
        ) else {
            return WidgetModel(todayProducts: [], dailyNutrition: NutritionModel())
        }
        return model
    }

    static func isShowMain() -> Bool {
        return UserDefaults.standard.bool(forKey: Constants.isShowMainId)
    }

    static func setIsShowMain(_ isShow: Bool) {
        UserDefaults.standard.set(isShow, forKey: Constants.isShowMainId)
    }

    static func isShowStartProfileSettings() -> Bool {
        return UserDefaults.standard.bool(forKey: Constants.isShowProfileId)
    }

    static func setIsShowStartProfileSettings(_ isShow: Bool) {
        UserDefaults.standard.set(isShow, forKey: Constants.isShowProfileId)
    }

    static func isThisDay() -> Bool {
        let date = UserDefaults.standard.object(forKey: Constants.dayTodayId) as? Date ?? Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let lastDate = dateFormatter.string(from: date)
        let nowDate = dateFormatter.string(from: Date())
        return lastDate == nowDate
    }

    static func setNowDay(_ date: Date) {
        UserDefaults.standard.set(date, forKey: Constants.dayTodayId)
    }
}
