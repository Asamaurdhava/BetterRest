//
//  ContentView.swift
//  BetterRest
//
//  Created by Vishesh S Rajput on 03/06/25.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var recommendedBedtime: String {
            do {
                let config = MLModelConfiguration()
                let model = try SleepCalculator(configuration: config)
                
                let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
                let hour = (components.hour ?? 0) * 60 * 60
                let minute = (components.minute ?? 0) * 60
                
                let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
                
                let sleepTime = wakeUp - prediction.actualSleep
                
                return sleepTime.formatted(date: .omitted, time: .shortened)
            } catch {
                return "Error calculating bedtime"
            }
        }
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                
                Section("When do you want to wake up?") {
                    
                    DatePicker("Please select the wkaeup time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section("Desired amount of sleep") {
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section("Daily coffee intake") {
                    
                    Picker("Number of cups", selection: $coffeeAmount) {
                        ForEach(1...20, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                    
                }
                
                Section("Your ideal bedtime") {
                    Text(recommendedBedtime)
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                
            }
            .navigationTitle("BetterRest")
            
        }
        
    }
}

#Preview {
    ContentView()
}
