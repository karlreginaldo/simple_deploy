simple_deploy is a quick and easy way to deploy apps to the store's test systems

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
  credentialsFile: "c:/credentials/project-credentials.json"
  packageName: "com.example.coolapp"
  whatsNew: "Simple bug fixes"

ios:
  teamKeyId: "ABCD1A4A12"
  developerId: "76a6aa66-e80a-67e9-e987-6a1c711a4b2
```

Here's the step-by-step instructions for configuring for each platform

[Android configuration](https://raw.githubusercontent.com/andrewpmoore/simple_deploy/refs/heads/main/android.md)

[iOS configuration](https://raw.githubusercontent.com/andrewpmoore/simple_deploy/refs/heads/main/ios.md)


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
[Android configuration](android.md)

### iOS configuration
[iOS configuration](ios.md)
