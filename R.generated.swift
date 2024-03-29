//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import RswiftResources
import UIKit

private class BundleFinder {}
let R = _R(bundle: Bundle(for: BundleFinder.self))

struct _R {
  let bundle: Foundation.Bundle

  let entitlements = entitlements()

  var string: string { .init(bundle: bundle, preferredLanguages: nil, locale: nil) }
  var color: color { .init(bundle: bundle) }
  var image: image { .init(bundle: bundle) }
  var info: info { .init(bundle: bundle) }
  var storyboard: storyboard { .init(bundle: bundle) }

  func string(bundle: Foundation.Bundle) -> string {
    .init(bundle: bundle, preferredLanguages: nil, locale: nil)
  }
  func string(locale: Foundation.Locale) -> string {
    .init(bundle: bundle, preferredLanguages: nil, locale: locale)
  }
  func string(preferredLanguages: [String], locale: Locale? = nil) -> string {
    .init(bundle: bundle, preferredLanguages: preferredLanguages, locale: locale)
  }
  func color(bundle: Foundation.Bundle) -> color {
    .init(bundle: bundle)
  }
  func image(bundle: Foundation.Bundle) -> image {
    .init(bundle: bundle)
  }
  func info(bundle: Foundation.Bundle) -> info {
    .init(bundle: bundle)
  }
  func storyboard(bundle: Foundation.Bundle) -> storyboard {
    .init(bundle: bundle)
  }
  func validate() throws {
    try self.storyboard.validate()
  }

  struct project {
    let developmentRegion = "en"
  }

  /// This `_R.string` struct is generated, and contains static references to 5 localization tables.
  struct string {
    let bundle: Foundation.Bundle
    let preferredLanguages: [String]?
    let locale: Locale?
    var addProductLocale: addProductLocale { .init(source: .init(bundle: bundle, tableName: "AddProductLocale", preferredLanguages: preferredLanguages, locale: locale)) }
    var generalLocale: generalLocale { .init(source: .init(bundle: bundle, tableName: "GeneralLocale", preferredLanguages: preferredLanguages, locale: locale)) }
    var launchScreen: launchScreen { .init(source: .init(bundle: bundle, tableName: "LaunchScreen", preferredLanguages: preferredLanguages, locale: locale)) }
    var mainScreenLocale: mainScreenLocale { .init(source: .init(bundle: bundle, tableName: "MainScreenLocale", preferredLanguages: preferredLanguages, locale: locale)) }
    var profileInfoLocale: profileInfoLocale { .init(source: .init(bundle: bundle, tableName: "ProfileInfoLocale", preferredLanguages: preferredLanguages, locale: locale)) }

    func addProductLocale(preferredLanguages: [String]) -> addProductLocale {
      .init(source: .init(bundle: bundle, tableName: "AddProductLocale", preferredLanguages: preferredLanguages, locale: locale))
    }
    func generalLocale(preferredLanguages: [String]) -> generalLocale {
      .init(source: .init(bundle: bundle, tableName: "GeneralLocale", preferredLanguages: preferredLanguages, locale: locale))
    }
    func launchScreen(preferredLanguages: [String]) -> launchScreen {
      .init(source: .init(bundle: bundle, tableName: "LaunchScreen", preferredLanguages: preferredLanguages, locale: locale))
    }
    func mainScreenLocale(preferredLanguages: [String]) -> mainScreenLocale {
      .init(source: .init(bundle: bundle, tableName: "MainScreenLocale", preferredLanguages: preferredLanguages, locale: locale))
    }
    func profileInfoLocale(preferredLanguages: [String]) -> profileInfoLocale {
      .init(source: .init(bundle: bundle, tableName: "ProfileInfoLocale", preferredLanguages: preferredLanguages, locale: locale))
    }


    /// This `_R.string.addProductLocale` struct is generated, and contains static references to 4 localization keys.
    struct addProductLocale {
      let source: RswiftResources.StringResource.Source

      /// en translation: Add dish
      ///
      /// Key: AddProduct.AddButton
      ///
      /// Locales: en, ru
      var addProductAddButton: RswiftResources.StringResource { .init(key: "AddProduct.AddButton", tableName: "AddProductLocale", source: source, developmentValue: "Add dish", comment: nil) }

      /// en translation: Calorie content of the dish
      ///
      /// Key: AddProduct.DishCallories
      ///
      /// Locales: en, ru
      var addProductDishCallories: RswiftResources.StringResource { .init(key: "AddProduct.DishCallories", tableName: "AddProductLocale", source: source, developmentValue: "Calorie content of the dish", comment: nil) }

      /// en translation: Name of the dish
      ///
      /// Key: AddProduct.Name
      ///
      /// Locales: en, ru
      var addProductName: RswiftResources.StringResource { .init(key: "AddProduct.Name", tableName: "AddProductLocale", source: source, developmentValue: "Name of the dish", comment: nil) }

      /// en translation: Adding a dish
      ///
      /// Key: AddProduct.Title
      ///
      /// Locales: en, ru
      var addProductTitle: RswiftResources.StringResource { .init(key: "AddProduct.Title", tableName: "AddProductLocale", source: source, developmentValue: "Adding a dish", comment: nil) }
    }

    /// This `_R.string.generalLocale` struct is generated, and contains static references to 12 localization keys.
    struct generalLocale {
      let source: RswiftResources.StringResource.Source

      /// en translation: You are not physically active and have a sedentary job.
      ///
      /// Key: PhysxState1
      ///
      /// Locales: en, ru
      var physxState1: RswiftResources.StringResource { .init(key: "PhysxState1", tableName: "GeneralLocale", source: source, developmentValue: "You are not physically active and have a sedentary job.", comment: nil) }

      /// en translation: Doing short runs or light gymnastics
      ///
      /// Key: PhysxState2
      ///
      /// Locales: en, ru
      var physxState2: RswiftResources.StringResource { .init(key: "PhysxState2", tableName: "GeneralLocale", source: source, developmentValue: "Doing short runs or light gymnastics", comment: nil) }

      /// en translation: You do sports with average loads 3-5 times a week
      ///
      /// Key: PhysxState3
      ///
      /// Locales: en, ru
      var physxState3: RswiftResources.StringResource { .init(key: "PhysxState3", tableName: "GeneralLocale", source: source, developmentValue: "You do sports with average loads 3-5 times a week", comment: nil) }

      /// en translation: You exercise fully 6-7 times a week
      ///
      /// Key: PhysxState4
      ///
      /// Locales: en, ru
      var physxState4: RswiftResources.StringResource { .init(key: "PhysxState4", tableName: "GeneralLocale", source: source, developmentValue: "You exercise fully 6-7 times a week", comment: nil) }

      /// en translation: Your work is related to physical labor, you train 2 times a day and include strength exercises in your training program
      ///
      /// Key: PhysxState5
      ///
      /// Locales: en, ru
      var physxState5: RswiftResources.StringResource { .init(key: "PhysxState5", tableName: "GeneralLocale", source: source, developmentValue: "Your work is related to physical labor, you train 2 times a day and include strength exercises in your training program", comment: nil) }

      /// en translation: Kkal
      ///
      /// Key: Unit.Callories
      ///
      /// Locales: en, ru
      var unitCallories: RswiftResources.StringResource { .init(key: "Unit.Callories", tableName: "GeneralLocale", source: source, developmentValue: "Kkal", comment: nil) }

      /// en translation: Carbs
      ///
      /// Key: Unit.Carbs
      ///
      /// Locales: en, ru
      var unitCarbs: RswiftResources.StringResource { .init(key: "Unit.Carbs", tableName: "GeneralLocale", source: source, developmentValue: "Carbs", comment: nil) }

      /// en translation: Fats
      ///
      /// Key: Unit.Fats
      ///
      /// Locales: en, ru
      var unitFats: RswiftResources.StringResource { .init(key: "Unit.Fats", tableName: "GeneralLocale", source: source, developmentValue: "Fats", comment: nil) }

      /// en translation: Сm
      ///
      /// Key: Unit.Height
      ///
      /// Locales: en, ru
      var unitHeight: RswiftResources.StringResource { .init(key: "Unit.Height", tableName: "GeneralLocale", source: source, developmentValue: "Сm", comment: nil) }

      /// en translation: Protein
      ///
      /// Key: Unit.Protein
      ///
      /// Locales: en, ru
      var unitProtein: RswiftResources.StringResource { .init(key: "Unit.Protein", tableName: "GeneralLocale", source: source, developmentValue: "Protein", comment: nil) }

      /// en translation: Kg
      ///
      /// Key: Unit.Weight
      ///
      /// Locales: en, ru
      var unitWeight: RswiftResources.StringResource { .init(key: "Unit.Weight", tableName: "GeneralLocale", source: source, developmentValue: "Kg", comment: nil) }

      /// en translation: Gr
      ///
      /// Key: Unit.Weight.Gr
      ///
      /// Locales: en, ru
      var unitWeightGr: RswiftResources.StringResource { .init(key: "Unit.Weight.Gr", tableName: "GeneralLocale", source: source, developmentValue: "Gr", comment: nil) }
    }

    /// This `_R.string.launchScreen` struct is generated, and contains static references to 0 localization keys.
    struct launchScreen {
      let source: RswiftResources.StringResource.Source
    }

    /// This `_R.string.mainScreenLocale` struct is generated, and contains static references to 4 localization keys.
    struct mainScreenLocale {
      let source: RswiftResources.StringResource.Source

      /// en translation: Daily calorie intake:
      ///
      /// Key: Main.DayliCallories
      ///
      /// Locales: en, ru
      var mainDayliCallories: RswiftResources.StringResource { .init(key: "Main.DayliCallories", tableName: "MainScreenLocale", source: source, developmentValue: "Daily calorie intake:", comment: nil) }

      /// en translation:      The last 10 dishes you ate:    
      ///
      /// Key: Main.LastDishes
      ///
      /// Locales: en, ru
      var mainLastDishes: RswiftResources.StringResource { .init(key: "Main.LastDishes", tableName: "MainScreenLocale", source: source, developmentValue: "     The last 10 dishes you ate:    ", comment: nil) }

      /// en translation: Main
      ///
      /// Key: Main.Title
      ///
      /// Locales: en, ru
      var mainTitle: RswiftResources.StringResource { .init(key: "Main.Title", tableName: "MainScreenLocale", source: source, developmentValue: "Main", comment: nil) }

      /// en translation: Good day
      ///
      /// Key: Welcome.Text
      ///
      /// Locales: en, ru
      var welcomeText: RswiftResources.StringResource { .init(key: "Welcome.Text", tableName: "MainScreenLocale", source: source, developmentValue: "Good day", comment: nil) }
    }

    /// This `_R.string.profileInfoLocale` struct is generated, and contains static references to 15 localization keys.
    struct profileInfoLocale {
      let source: RswiftResources.StringResource.Source

      /// en translation: Additional Information
      ///
      /// Key: Profile.AdditionalInfo
      ///
      /// Locales: en, ru
      var profileAdditionalInfo: RswiftResources.StringResource { .init(key: "Profile.AdditionalInfo", tableName: "ProfileInfoLocale", source: source, developmentValue: "Additional Information", comment: nil) }

      /// en translation: Your birthday
      ///
      /// Key: Profile.Birthday
      ///
      /// Locales: en, ru
      var profileBirthday: RswiftResources.StringResource { .init(key: "Profile.Birthday", tableName: "ProfileInfoLocale", source: source, developmentValue: "Your birthday", comment: nil) }

      /// en translation: Enter your birthday
      ///
      /// Key: Profile.Enter.Birthday
      ///
      /// Locales: en, ru
      var profileEnterBirthday: RswiftResources.StringResource { .init(key: "Profile.Enter.Birthday", tableName: "ProfileInfoLocale", source: source, developmentValue: "Enter your birthday", comment: nil) }

      /// en translation: Enter your height...
      ///
      /// Key: Profile.Enter.Height
      ///
      /// Locales: en, ru
      var profileEnterHeight: RswiftResources.StringResource { .init(key: "Profile.Enter.Height", tableName: "ProfileInfoLocale", source: source, developmentValue: "Enter your height...", comment: nil) }

      /// en translation: Enter your name...
      ///
      /// Key: Profile.Enter.Name
      ///
      /// Locales: en, ru
      var profileEnterName: RswiftResources.StringResource { .init(key: "Profile.Enter.Name", tableName: "ProfileInfoLocale", source: source, developmentValue: "Enter your name...", comment: nil) }

      /// en translation: Enter physical state...
      ///
      /// Key: Profile.Enter.PhysxState
      ///
      /// Locales: en, ru
      var profileEnterPhysxState: RswiftResources.StringResource { .init(key: "Profile.Enter.PhysxState", tableName: "ProfileInfoLocale", source: source, developmentValue: "Enter physical state...", comment: nil) }

      /// en translation: Enter your weight...
      ///
      /// Key: Profile.Enter.Weight
      ///
      /// Locales: en, ru
      var profileEnterWeight: RswiftResources.StringResource { .init(key: "Profile.Enter.Weight", tableName: "ProfileInfoLocale", source: source, developmentValue: "Enter your weight...", comment: nil) }

      /// en translation: Female
      ///
      /// Key: Profile.Female
      ///
      /// Locales: en, ru
      var profileFemale: RswiftResources.StringResource { .init(key: "Profile.Female", tableName: "ProfileInfoLocale", source: source, developmentValue: "Female", comment: nil) }

      /// en translation: Your height
      ///
      /// Key: Profile.Height
      ///
      /// Locales: en, ru
      var profileHeight: RswiftResources.StringResource { .init(key: "Profile.Height", tableName: "ProfileInfoLocale", source: source, developmentValue: "Your height", comment: nil) }

      /// en translation: Male
      ///
      /// Key: Profile.Male
      ///
      /// Locales: en, ru
      var profileMale: RswiftResources.StringResource { .init(key: "Profile.Male", tableName: "ProfileInfoLocale", source: source, developmentValue: "Male", comment: nil) }

      /// en translation: Your name
      ///
      /// Key: Profile.Name
      ///
      /// Locales: en, ru
      var profileName: RswiftResources.StringResource { .init(key: "Profile.Name", tableName: "ProfileInfoLocale", source: source, developmentValue: "Your name", comment: nil) }

      /// en translation: Select your physical activity
      ///
      /// Key: Profile.Select.PhysicalActivity
      ///
      /// Locales: en, ru
      var profileSelectPhysicalActivity: RswiftResources.StringResource { .init(key: "Profile.Select.PhysicalActivity", tableName: "ProfileInfoLocale", source: source, developmentValue: "Select your physical activity", comment: nil) }

      /// en translation: Start
      ///
      /// Key: Profile.Start
      ///
      /// Locales: en, ru
      var profileStart: RswiftResources.StringResource { .init(key: "Profile.Start", tableName: "ProfileInfoLocale", source: source, developmentValue: "Start", comment: nil) }

      /// en translation: Filling out the form
      ///
      /// Key: Profile.Title.FillForm
      ///
      /// Locales: en, ru
      var profileTitleFillForm: RswiftResources.StringResource { .init(key: "Profile.Title.FillForm", tableName: "ProfileInfoLocale", source: source, developmentValue: "Filling out the form", comment: nil) }

      /// en translation: Your weight
      ///
      /// Key: Profile.Weight
      ///
      /// Locales: en, ru
      var profileWeight: RswiftResources.StringResource { .init(key: "Profile.Weight", tableName: "ProfileInfoLocale", source: source, developmentValue: "Your weight", comment: nil) }
    }
  }

  /// This `_R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    let bundle: Foundation.Bundle

    /// Color `AccentColor`.
    var accentColor: RswiftResources.ColorResource { .init(name: "AccentColor", path: [], bundle: bundle) }
  }

  /// This `_R.image` struct is generated, and contains static references to 1 images.
  struct image {
    let bundle: Foundation.Bundle

    /// Image `number5`.
    var number5: RswiftResources.ImageResource { .init(name: "number5", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }
  }

  /// This `_R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    let bundle: Foundation.Bundle
    var uiApplicationSceneManifest: uiApplicationSceneManifest { .init(bundle: bundle) }

    func uiApplicationSceneManifest(bundle: Foundation.Bundle) -> uiApplicationSceneManifest {
      .init(bundle: bundle)
    }

    struct uiApplicationSceneManifest {
      let bundle: Foundation.Bundle

      let uiApplicationSupportsMultipleScenes: Bool = false

      var _key: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest"], key: "_key") ?? "UIApplicationSceneManifest" }
    }
  }

  /// This `_R.entitlements` struct is generated, and contains static references to 1 properties.
  struct entitlements {
    let comAppleSecurityApplicationGroups = comAppleSecurityApplicationGroups()
    struct comAppleSecurityApplicationGroups {
      let groupTimisHealthtifyWidget: String = "group.timis.Healthtify.Widget"
    }
  }

  /// This `_R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    let bundle: Foundation.Bundle
    var launchScreen: launchScreen { .init(bundle: bundle) }

    func launchScreen(bundle: Foundation.Bundle) -> launchScreen {
      .init(bundle: bundle)
    }
    func validate() throws {
      try self.launchScreen.validate()
    }


    /// Storyboard `LaunchScreen`.
    struct launchScreen: RswiftResources.StoryboardReference, RswiftResources.InitialControllerContainer {
      typealias InitialController = UIKit.UIViewController

      let bundle: Foundation.Bundle

      let name = "LaunchScreen"
      func validate() throws {

      }
    }
  }
}