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
            data: WidgetModel()
        )
    }

    func getSnapshot(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (SimpleEntry) -> Void
    ) {
        let userDefaults = UserDefaults(suiteName: "group.timis.Healthtify.Widget")
        guard let data = userDefaults?.object(forKey: "dailyInfo") as? Data else { return }

        guard let data = try? JSONDecoder().decode(WidgetModel.self, from: data) else { return }

        let entry = SimpleEntry(date: Date(), configuration: configuration, data: data)
        completion(entry)
    }

    func getTimeline(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (Timeline<Entry>) -> Void
    ) {
        var entries: [SimpleEntry] = []
        var dataWidget: WidgetModel?

        let userDefaults = UserDefaults(suiteName: "group.timis.Healthtify.Widget")
        if let data = userDefaults?.object(forKey: "dailyInfo") as? Data {
            if let data = try? JSONDecoder().decode(WidgetModel.self, from: data) {
                dataWidget = data
            }
        }

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
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
                        Text("\(data.nowProtein)/\(data.dayliProtein)")
                    }
                    VStack(alignment: .center, spacing: 10) {
                        Text("Protein")
                        Text("\(data.nowFats)/\(data.dayliFats)")
                        VStack(alignment: .center, spacing: 20) {
                            Text("Callories")
                            Text("\(data.nowCallories)/\(data.dayliCallories)")
                        }
                    }
                    VStack(alignment: .center, spacing: 10) {
                        Text("Carbs")
                        Text("\(data.nowCarbs)/\(data.dayliCarbs)")
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
                data: WidgetModel()
            )
        )
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
