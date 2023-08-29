//
//  HealthyCardWidget.swift
//  HealthyCardWidget
//
//  Created by Timur Israilov on 14/12/21.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(
            date: Date(),
            configuration: ConfigurationIntent(),
            data: WidgetModel(currentNutrition: NutritionModel(), dailyNutrition: NutritionModel())
        )
    }

    func getSnapshot(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (SimpleEntry) -> Void
    ) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, data: UserSettings.getDataWidget())
        completion(entry)
    }

    func getTimeline(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (Timeline<Entry>) -> Void
    ) {
        var entries: [SimpleEntry] = []
        let dataWidget: WidgetModel = UserSettings.getDataWidget()

        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, data: dataWidget)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let data: WidgetModel?
}

struct HealthyCardWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        if let data = entry.data {
            VStack(alignment: .center, spacing: 10) {
                HStack(alignment: .center, spacing: 50) {
                    VStack(alignment: .center, spacing: 10) {
                        Text("Fats")
                        Text("\(data.currentNutrition.fats)/\(data.dailyNutrition.fats)")
                    }
                    VStack(alignment: .center, spacing: 10) {
                        Text("Protein")
                        Text("\(data.currentNutrition.proteins)/\(data.dailyNutrition.proteins)")
                        VStack(alignment: .center, spacing: 20) {
                            Text("Callories")
                            Text("\(data.currentNutrition.callories)/\(data.dailyNutrition.callories)")
                        }
                    }
                    VStack(alignment: .center, spacing: 10) {
                        Text("Carbs")
                        Text("\(data.currentNutrition.carbs)/\(data.dailyNutrition.carbs)")
                    }
                }

                HStack(alignment: .center, spacing: 50) {
                }
            }
        } else {
            Text("Please enter your information")
        }
    }
}

@main
struct HealthyCardWidget: Widget {
    let kind: String = "HealthyCardWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            HealthyCardWidgetEntryView(entry: entry)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

struct HealthyCardWidget_Previews: PreviewProvider {
    static var previews: some View {
        HealthyCardWidgetEntryView(
            entry: SimpleEntry(
                date: Date(),
                configuration: ConfigurationIntent(),
                data: WidgetModel(currentNutrition: NutritionModel(), dailyNutrition: NutritionModel())
            )
        )
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
