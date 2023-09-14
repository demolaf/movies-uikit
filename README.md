### A Movies iOS application built with UIKit (ViewCode), VIPER, Realm, Alamofire and RxSwift.
[![HitCount](https://hits.dwyl.com/demolaf/movies-uikit.svg?style=flat-square&show=unique)](http://hits.dwyl.com/demolaf/movies-uikit)

### Content
* [Description](#description)
* [Preview](#preview)
* [Running the App](#running-the-app)
* [App Architecture & Folder Structure](#app-architecture-and-folder-structure)

## Description
An example iOS project built using UIKit (View Code) and shows how to implement the VIPER architecture.

## Preview
https://github.com/demolaf/movies-uikit/assets/48495111/eee18e7c-8e47-405b-a42a-f2e943f07310

## Running the App

### Setting up Carthage
Quick start to getting carthage installed and running this app

Link to guide [here](https://github.com/Carthage/Carthage#quick-start) 


### Setting up Environment config for secret keys
Check out this article to setup secret keys using xcconfig and property list file.

Link to article [here](https://moinulhassan.medium.com/read-variables-from-env-file-to-xcconfig-files-for-different-schemes-in-xcode-3ef977a0eef8)

### Code linting using SwiftLint (Optional)
You can learn more about linting in swift.

Link to guide [here](https://github.com/realm/SwiftLint)

## App Architecture and Folder Structure

#### Folder Structure

```
movies_uikit 
 ├── Resources
 │   └── Animations
 │   └── Fonts
 │   └── Assets
 ├── Application
 ├── Core
 ├── Data
 │   ├── Datasources
 │   │   └── Local Storage
 │   │   └── HTTP Client
 │   ├── Repositories
 │   │   └── Auth Repository
 │   │   └── Movies Repository
 │   │   └── User Repository
 │   ├── Models
 │   │   └── Request
 │   │   └── Response
 ├── Modules
 │   ├── Shared
 │   ├── Login
 │   ├── Launch
 │   ├── Main Tab
 │   ├── TV Shows
 │   ├── Movies
 │   ├── Library
 │   ├── Detail
 ├── Info.plist
 ├── Development.xcconfig
 └── Tests
```
