# BetterRest

A SwiftUI and Core ML powered sleep calculator that predicts optimal bedtime based on wake-up time, desired sleep duration, and daily caffeine intake.

## Overview

BetterRest is an intelligent iOS application that leverages machine learning to help users optimize their sleep schedule. By analyzing personal sleep patterns and caffeine consumption, the app provides personalized bedtime recommendations using Apple's Core ML framework for on-device prediction.

### Core Functionality
- **Smart Bedtime Calculation**: ML-powered predictions based on multiple sleep factors
- **Personalized Input**: Customizable wake-up time, sleep duration, and coffee intake
- **Real-time Updates**: Instant bedtime recommendations as inputs change
- **Intuitive Interface**: Clean form-based design with native iOS controls
- **Privacy-First**: All calculations performed on-device using Core ML

## Features

### Machine Learning Integration
- **Core ML Model**: `SleepCalculator` model for accurate sleep predictions
- **Multi-factor Analysis**: Considers wake time, desired sleep hours, and caffeine intake
- **Real-time Processing**: Instant calculations without network dependency
- **Error Handling**: Graceful fallback for prediction failures

### User Interface
- **Form-Based Design**: Organized sections for logical input grouping
- **Native Controls**: DatePicker, Stepper, and Picker for optimal user experience
- **Dynamic Updates**: Computed property automatically updates bedtime display
- **Professional Styling**: Large title display for bedtime results

### Input Parameters
- **Wake-up Time**: Hour and minute selection with DatePicker
- **Sleep Duration**: 4-12 hours range with 0.25-hour increments via Stepper
- **Coffee Intake**: 1-20 cups selection using Picker component
- **Default Values**: Sensible defaults (7:00 AM wake-up, 8 hours sleep, 1 cup coffee)

## Requirements

- **iOS**: 14.0+
- **Xcode**: 12.0+
- **Swift**: 5.3+
- **Core ML**: Framework included
- **SleepCalculator.mlmodel**: Pre-trained ML model file

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/BetterRest.git
   ```
2. Open `BetterRest.xcodeproj` in Xcode
3. Ensure `SleepCalculator.mlmodel` is properly added to the project bundle
4. Build and run on your preferred device or simulator

## Usage

### Setting Your Preferences
1. **Wake-up Time**: Use the time picker to set your desired wake-up time
2. **Sleep Duration**: Adjust the stepper to select your target sleep hours (4-12 hours)
3. **Coffee Intake**: Choose your daily coffee consumption (1-20 cups)
4. **View Results**: Your ideal bedtime appears automatically in the results section

### Understanding the Results
The app calculates your optimal bedtime by:
- Converting wake-up time to seconds since midnight
- Factoring in desired sleep duration
- Accounting for caffeine's impact on sleep quality
- Using ML predictions to determine the best bedtime

## Code Architecture

### Core ML Integration
```swift
var recommendedBedtime: String {
    do {
        let config = MLModelConfiguration()
        let model = try SleepCalculator(configuration: config)
        
        let prediction = try model.prediction(
            wake: Double(hour + minute), 
            estimatedSleep: sleepAmount, 
            coffee: Double(coffeeAmount)
        )
        
        let sleepTime = wakeUp - prediction.actualSleep
        return sleepTime.formatted(date: .omitted, time: .shortened)
    } catch {
        return "Error calculating bedtime"
    }
}
```

### State Management
```swift
@State private var wakeUp = defaultWakeTime
@State private var sleepAmount = 8.0
@State private var coffeeAmount = 1

static var defaultWakeTime: Date {
    var components = DateComponents()
    components.hour = 7
    components.minute = 0
    return Calendar.current.date(from: components) ?? .now
}
```

### Form Structure
- **Sectioned Layout**: Logical grouping of related inputs
- **Computed Properties**: Real-time bedtime calculation
- **Data Binding**: Two-way binding with @State properties
- **Error Handling**: Safe ML model loading and prediction

## Technical Concepts Demonstrated

### Advanced iOS Development
- **Core ML Integration**: On-device machine learning implementation
- **SwiftUI Form Design**: Complex form layouts with multiple input types
- **Date Manipulation**: Calendar components and date formatting
- **Computed Properties**: Reactive UI updates based on state changes
- **Error Handling**: Robust exception management for ML operations

### Machine Learning Features
- **Model Configuration**: MLModelConfiguration setup
- **Multi-input Predictions**: Handling multiple parameter types
- **Data Preprocessing**: Converting time to seconds for ML input
- **Result Processing**: Converting ML output to user-friendly format

## Educational Value

This project illustrates several key iOS development concepts:
- **Core ML Framework**: Integrating machine learning into iOS applications
- **SwiftUI Advanced UI**: Complex form layouts and data binding
- **Date and Time Handling**: Working with Calendar and DateComponents
- **State Management**: Reactive programming with @State properties
- **Model-View Architecture**: Separating data processing from UI presentation

## Use Cases

### Practical Applications
- **Sleep Optimization**: Personal sleep schedule improvement
- **Health Tracking**: Integration with health and wellness apps
- **Productivity Enhancement**: Better rest for improved daily performance
- **Machine Learning Education**: Learning Core ML implementation patterns

## Acknowledgements

This project is based on Paul Hudson's 100 Days of SwiftUI course. All credit for the original concept, structure, and educational content goes to Paul Hudson and the Hacking with Swift community. This repository is intended solely for personal learning and demonstration.

## Author

**Vishesh Singh Rajput aka specstan**

## License

This project is created for educational purposes as part of learning iOS development with SwiftUI and Core ML. The implementation follows Paul Hudson's tutorial structure and is intended for personal skill development and portfolio demonstration.

For commercial use or distribution, please refer to the original course terms and conditions.
