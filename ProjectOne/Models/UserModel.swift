//
//  UserModel.swift
//  ProjectOne
//
//  Created by Timur Israilov on 28/08/23.
//

import Foundation

enum Gender: Int {
    case male
    case female
}

enum PhysicalState: Int {
    case noneActivity
    case smallActivity
    case mediumActivity
    case fullWeekActivity
    case hardTraining
}

struct UserModel {
    let name: String
    let birthday: Date
    let gender: Gender
    let physicalState: PhysicalState
    let weight: Int
    let height: Int

    init(
        name: String = "",
        birthday: Date = Date(),
        gender: Gender = .male,
        physicalState: PhysicalState = .noneActivity,
        weight: Int = 0,
        height: Int = 0
    ) {
        self.name = name
        self.birthday = birthday
        self.gender = gender
        self.physicalState = physicalState
        self.weight = weight
        self.height = height
    }

    init(_ coreDataModel: UserCoreData) {
        self.name = coreDataModel.name ?? ""
        self.birthday = coreDataModel.birthday ?? Date()
        self.gender = Gender(rawValue: Int(coreDataModel.gender)) ?? .male
        self.height = Int(coreDataModel.height)
        self.weight = Int(coreDataModel.weight)
        self.physicalState = PhysicalState(rawValue: Int(coreDataModel.physicalState)) ?? .noneActivity
    }
}
