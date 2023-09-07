# Assignment readme

# My Steps

## Mini coding assignment

Disclaimer:
This document and all accompanying material is strictly private, confidential and personal to its recipients and should not be copied, distributed or reproduced in whole or in part, nor passed to any third party.

## Quick Overview

This is a simple hypothetical app to track your steps and reward you along the way.

## About the app

The name of this hypothetical app is: MySteps. The app uses HealthKit to retrieve the amount of steps in Apple Health, and shows a graph of the the amount of steps taken for the current month along with a set of achievements at the bottom. 

The app should query Apple Health for the Steps category for the current month and then:

- Display the total steps for the current month
- On the same view, plot a line chart depicting the steps. (x-axis day of month / y-axis step count/per day)
-  The y-axis of the chart should start from zero and adjust dynamically  depending on the total amount of steps returned by Apple Health for the current month.
- On the same view, display all the achievements earned for the current month based on the total sum of steps taken for the current month. (i.e. If the user has walked 0-9999 steps show the “No achievements” state, if the user has walked 10k show the first badge, if the user has walked 20k show the first and second badge etc.  )
- On a new view that should be created from scratch, display the detail view of the current achievement.

The achievements view is scrollable horizontally and the entire view should be scrollable vertically.

All strings should be marked as localisable and the UI elements should expand and contract to accommodate larger or smaller strings, depending on the hypothetical translation.

## Design & Assets
You will receive an invitation to Figma via email.

## Animation prototype
The animation prototype can be accessed in Figma as well by accessing the *Prototype* tab of the sidebar.

### Project configuration
1. The app should be developed in Swift 
2. The deployment target is iOS 16 or later - iPhone only
3. The supported interface orientations for the app should be Portrait Only
4. The app should run properly on all available iPhone size classes (no iPad version)
5. You can use SwiftUI or UIKit for the UI
6. You can use external dependencies (Pods/Swift packages) if you desire
7. The project must be built with XCode. The use of other editors, builders, custom scripting tools is prohibited.  

### Data & Backend
1. The chart should display the total number of steps for each of the current month - displayed data should adapt when day changes
2. The app should ask for permission to access the user’s “Steps” Apple Health category.
3. The total number of steps for each day should be also stored locally in the app, using a Core Data Persistent store (a local cache).
4. The data for the chart should be retrieved directly from HealthKit every time the app is launched.
5. The data for the achievements views should be retrieved from the local cache.
6. The images for the achievements should be bundled in the app.
7. The image when no achievement exists is bundled in the template's asset catalog.

### Localization
1. All dates appearing should be adapting to the user’s locale (in terms of language and formatting)
2. The app is considered to be localised, so all text UI elements used should be able to accommodate strings of variable length without breaking the app’s layout - All strings used should be treated as `NSLocalizedStrings`
3. A sample localization (French) should also be supported. When the app’s language is set to French, all strings inside the app should be presented having an `_fr` suffix (no actual translation is required)

### What we’ll evaluate
1. Clean and well documented code
2. Performance of the app
3. Attention to detail in the implementation of the UI (Distances, sizes, typography, animation etc.)
# HealthStepsDemo
