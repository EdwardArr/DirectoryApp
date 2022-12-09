# The Directory App

## Build tools & versions used
* Xcode 14.1
* SwiftUI 4
* Swift 5

## Steps to run the app
1. Download the code.
2. Open Directory.xcodeproj on Xcode.
3. Build and run the app in the simulator or physical iPhone.

*The app is built for iPhone on portrait only.*

## What areas of the app did you focus on?
The main focus areas are reliability, energy consumption, and UI/UX.

## What was the reason for your focus? What problems were you trying to solve?
The Directory app depends on an AWS endpoint to display employee information. Therefore the process of retrieving the employee information is coded with functional programming so each step can be tested. Once reliability is ensured, the focus becomes energy consumption. Image caching is implemented to minimize network requests and thus conserve battery life. Finally, the app has a simple UX/UI to help users swiftly find and contact an employee and get alerts if the app is experiencing errors.

## How long did you spend on this project?
Approxiametly 8 hours.

## Did you make any trade-offs for this project? What would you have done differently with more time?
Due to limited time, I was not able to complete the following:
* UI unit tests. If I had more time, I would first build tests for the different states of the EmployeePhotoView.
* Use Grid view. If I had more time, I would add a two column Grid View to the employees list.
* Manual photo refresh. If I had more time, I would make the EmployeePhotoView a button that would fetch image once tapped on. 

## What do you think is the weakest part of your project?
I believe the weakest part of the project is the code readability. Comments are not consistent, function names should be more descriptive and some code should have its own file.

## Did you copy any code or dependencies? Please make sure to attribute them here!
Copied code for the following:
* Image caching - https://github.com/tunds?tab=repositories&q=&type=&language=&sort= 
* Teams filter button - CPT Library (an iOS app I built)

## Is there any other information you’d like us to know?
The MVVM principles are utilized to architect the codebase. Some files did not belong in the MVVM folders, so three additional folders called App, Managers, and Extensions were created. On another note, the app is designed with assumptions if not mentioned in the Mobile Take-Home Project site. In a real project, I avoid assumptions and ask detailed questions before diving into a project.
