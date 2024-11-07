import 'dart:io';

import 'package:simple_deploy/src/deploy_android.dart' as android;
import 'package:simple_deploy/src/deploy_ios.dart' as ios;

bool checkDeployFile() {
  final workingDirectory = Directory.current.path;
  final configFile = File('$workingDirectory/deploy.yaml');
  return configFile.existsSync();
}

void main(List<String> arguments) async {
  if (!checkDeployFile()) {
    print('Error: deploy.yaml file not found in the root of the project.');
    return;
  }

  // Check if arguments are passed
  if (arguments.isEmpty) {
    // No arguments, ask the user for input
    await promptAndDeploy();
  } else {
    // Arguments are passed, assume they are 'ios' or 'android'
    String target = arguments[0].toLowerCase();
    if (target == 'ios') {
      if (Platform.isMacOS) {
        await deployIos();
      }
      else{
        print('Error: You can only deploy to test flight on from MacOS');
        return;
      }
    } else if (target == 'android') {
      await deployAndroid();
    } else {
      print('Invalid argument. Please pass "ios" or "android".');
    }
  }
}

// Prompt the user to choose iOS or Android for deployment
Future<void> promptAndDeploy() async {
  print('Choose deployment target:');
  print('1. Android');
  if (Platform.isMacOS) {
    print('2. iOS');
  }

  // Read user input
  String? choice;
  if (Platform.isMacOS) {
    choice = stdin.readLineSync();
  } else {
    choice = '1';
  }

  if (choice == '1') {
    await deployAndroid();
  } else if (choice == '2') {
    await deployIos();
  } else {
    if (Platform.isMacOS) {
      print('Invalid choice. Please enter 1 or 2.');
    } else {
      print('Invalid choice. Please enter 1');
    }
  }
}

// Run iOS deployment
Future<void> deployIos() async {
  print('Deploying to iOS...');
  ios.deploy();
}

// Run Android deployment
Future<void> deployAndroid() async {
  print('Deploying to Android...');
  android.deploy();
}
