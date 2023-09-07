
//  CUIStep+Graph.swift
//  MySteps
//
//  Created by Nico Dioso on 8/4/23.
//

import SwiftUI
import Charts

extension CUIStep {
    struct Graph: View {
        
        let monthData: MonthStepsData
        
        // This is for adjusting max domain of y-axis to show the next value of the axis
        private var yDomain: [Int] {
            guard let maxValue = monthData.data.max(by: { $0.stepCount < $1.stepCount })?.stepCount
            else {
                return [0, 1000]
            }
            let stepThreshold = 50
            let chunkStep = Int(maxValue/stepThreshold)
            let adjustedSteps = chunkStep+3
            let adjustedValue = adjustedSteps*stepThreshold
            return [0, adjustedValue]
        }
        
        var body: some View {
            ZStack {
                Chart(monthData.data) { activity in
                    LineMark(
                        x: .value("Week Day", activity.monthDay),
                        y: .value("Step Count", activity.stepCount)
                    )
                    .interpolationMethod(.monotone)
                    .lineStyle(.init(lineWidth: 3))
                    .foregroundStyle(.linearGradient(colors: [.appGreen, .appBlue], startPoint: .top, endPoint: .bottom))
                }
                .chartXScale(range: .plotDimension(startPadding: 20, endPadding: 20))
                .chartXAxis {
                    AxisMarks(
                        preset: .aligned,
                        values: calculateGraphXAxisMonthDays()
                    ) {
                        AxisValueLabel()
                            .foregroundStyle(.white.opacity(0.5))
                    }
                }
                .chartYScale(domain: yDomain, range: .plotDimension(endPadding: 10))
                .chartYAxis {
                    AxisMarks {
                        AxisValueLabel(anchor: .bottomTrailing)
                            .offset(x: 23)
                            .foregroundStyle(.white.opacity(0.5))
                        AxisGridLine()
                            .foregroundStyle(.white.opacity(0.5))
                        AxisTick(length: .longestLabel)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                }
                .frame(height: 140)
            }
        }
        
        /// returns an Array of days in intervals of 5 which are to be shown in a graph. Also includes day 1.
        private func calculateGraphXAxisMonthDays() -> [Int] {
            var days = [1]
            let monthDaysIntervalOf5 = Array(1...6).map { $0*5 }
            days += monthDaysIntervalOf5
            return days
        }
    }
}

struct StepGraphPreview: PreviewProvider {
    
    static var previews: some View {
        ZStack {
            Color.white
            Color.black.opacity(0.8)
            HStack(spacing: 0) {
                Color.blue
                    .frame(width: 24)
                Color.clear
                Color.blue
                    .frame(width: 16)
            }.opacity(0.3)
            CUIStep.Graph(monthData: .init(
                monthDate: Date().firstDayOfTheMonth,
                data: Array(1..<29).map {
                    .init(
                        monthDay: $0,
                        stepCount: .random(in: 200...1000)
                    )
                }
            ))
            .background(Color.orange.opacity(0.3))
        }
    }
}
