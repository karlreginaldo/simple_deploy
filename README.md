<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->

simple_deploy is a quick and easy way to deploy apps to the stores test systems

NOTE: This is very much a work-in-progress package at the moment, until it reaches version 1.0

## Features

Deploy to iOS Test Flight
Deploy to Android Play Store Test Track

## Getting started
Install the dependency into your `pubspec.yaml` with the follow

```
dev_dependencies:
  simple_deploy: latest_version # e.g. ^0.8.0
```

Create a `deploy.yaml` file at the root of your project and configure it

Here is an example version of `deploy.yaml`
```
android:
  credentialsFile: "c:/credentials/project-ha4udk.json"
  packageName: "com.example.coolapp"
  whatsNew: "Simple bug fixes"

ios:
  apiKey: "ABCD1A4A12"
  apiIssuer: "76a6aa66-e80a-67e9-e987-6a1c711a4b2
```


## Usage

Just run `dart run simple_deploy` and select the deployment platform

You can also supply the platform with 
 - `dart run simple_deploy android`
 - `dart run simple_deploy ios`

## Additional information
You'll need to get some developer details from App Store connect for the deploy.yaml file
You will also need to set up a google cloud project to create the `.json` file required for android.
See steps below of these:

### Android configuration
TODO

### iOS configuration
TODO
