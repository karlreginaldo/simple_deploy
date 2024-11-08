import 'dart:io';

import 'package:simple_deploy/src/common.dart';
import 'package:simple_deploy/src/deploy_android.dart' as android;
import 'package:simple_deploy/src/deploy_ios.dart' as ios;
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

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

  if (arguments.isEmpty) {
    await promptAndDeploy();
  } else {
    String target = arguments[0].toLowerCase();
    if (target == 'ios') {
      if (Platform.isMacOS) {
        await deployIos();
      } else {
        print('Error: You can only deploy to iOS from MacOS.');
        return;
      }
    } else if (target == 'android') {
      await deployAndroid();
    } else {
      print('Invalid argument. Please pass "ios" or "android".');
    }
  }
}

Future<void> promptAndDeploy() async {
  if (Platform.isMacOS) {
    print('Choose deployment target:');
    print('1. Android');
    print('2. iOS');
    print('a. All platforms');
    print('q. Quit');
  } else {
    print('Automatically selecting Android build and deploy');
  }

  String? choice = Platform.isMacOS ? stdin.readLineSync() : '1';

  if (choice == '1') {
    await deployAndroid();
  } else if (choice == '2') {
    await deployIos();
  } else if (choice == 'a') {
    await deployAll();
  } else if (choice == 'q') {
    print('Quitting deployment.');
  } else {
    print(Platform.isMacOS
        ? 'Invalid choice. Please enter 1, 2, a, or q.'
        : 'Invalid choice. Please enter 1.');
  }
}

Future<void> deployIos() async {
  print('Deploying to iOS...');
  await ios.deploy();
}

Future<void> deployAndroid() async {
  print('Deploying to Android...');
  await android.deploy();
}

Future<void> deployAll() async {
  print('Deploying to all platforms...');
  await deployAndroid();
  if (Platform.isMacOS) {
    await deployIos();
  } else {
    print('iOS deployment is only available on MacOS.');
  }
}

Future<void> handleVersionStrategy() async {
  final workingDirectory = Directory.current.path;
  final config = await loadConfig(workingDirectory, 'common');
  final versionStrategy = config['trackName'] ?? 'none';

  if (versionStrategy == 'pubspecIncrement') {
    await incrementBuildNumber();
  } else if (versionStrategy == 'none') {
    // Do nothing
  } else {
    print('Invalid versionStrategy. Valid values are `none` and `pubspecIncrement`.');
    return;
  }
}

Future<void> incrementBuildNumber() async {
  final pubspecFile = File('pubspec.yaml');
  final pubspecContent = await pubspecFile.readAsString();

  final doc = loadYaml(pubspecContent);
  final editor = YamlEditor(pubspecContent);

  final currentVersion = doc['version'] as String;
  final versionParts = currentVersion.split('+');
  final versionNumber = versionParts[0];
  final currentBuildNumber = int.parse(versionParts.length > 1 ? versionParts[1] : '0');

  final newBuildNumber = currentBuildNumber + 1;
  final newVersion = '$versionNumber+$newBuildNumber';

  editor.update(['version'], newVersion);
  await pubspecFile.writeAsString(editor.toString());
  print('Updated build number to $newBuildNumber in pubspec.yaml');
}
