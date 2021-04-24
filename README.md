# Smart Notepad
> Smart Notepad is a mini app that you use to add personal notes. You can add notes and attach a location and/or images. Users can open their notes and edit them.

## Table of contents
* [Screenshots](#screenshots)
* [Requirements](#requirements)
* [Setup](#setup)
* [Features](#features)
* [Contact](#contact)


## Screenshots
![Example screenshot]("https://github.com/islamnabil/SmartNotepad/blob/main/ScreenShoots/1.png")

## Requirements
* Xcode 10.2+
* Swift 5+
* iOS 13+

## Setup
### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To install pods `Podfile` in  into your Xcode project using CocoaPods, open your terminal in project's directory:

```ruby
pod install
```

## Features
List of features ready and TODOs for future development
* My Notes List Screen, a list of all notes.
* Each note is represented on a UI element. A note UI element may have an icon denoting it has a GPS location and/or an icon denoting it has an image.
* Note Details Screen, to view, create, edit or delete a note.
* Notes are saved in the app permanent data storage by `Realm`.
* The first note on the list is the one having the nearest location from the current user location. It has a specific UI tagging it as the nearest note.
* All other notes are sorted by creation time in descending order.

To-do list:
* Implementing Unit tests.

## Contact
Created by [@islamnabil](https://github.com/islamnabil) - feel free to contact me!
