#!/usr/bin/env dart

import 'dart:io';
import 'package:yaml/yaml.dart';

// Function to handle errors
void handleError(String message) {
  print("Error: $message");
  exit(1);
}

// Load configuration from a YAML file
Future<YamlMap> loadConfig(String workingDirectory) async {
  final configFile = File('$workingDirectory/deploy.yaml');
  final configContent = await configFile.readAsString();
  final yamlMap = loadYaml(configContent);

  // Manually convert YamlMap to Map<String, dynamic>
  final Map<String, dynamic> configMap = {};
  for (var key in yamlMap.keys) {
    configMap[key] = yamlMap[key];
  }

  return configMap['ios'];
}



void deploy() async {
  final workingDirectory = Directory.current.path;

  final config = await loadConfig(workingDirectory);

  // Run iOS deployment
  final apiKey = config['apiKey'];
  final apiIssuer = config['apiIssuer'];

  DateTime startTime = DateTime.now();

  print('Clean the project');
  var result = await Process.run('flutter', ['clean'], workingDirectory: workingDirectory, runInShell: true);
  if (result.exitCode != 0) {
    handleError('flutter clean failed: ${result.stderr}');
  }

  print('Build the Flutter IPA');
  result = await Process.run('flutter', ['build', 'ipa'], workingDirectory: workingDirectory, runInShell: true);
  if (result.exitCode != 0) {
    handleError('flutter build ipa failed: ${result.stderr}');
  }

  print('Uploading the IPA to TestFlight');
  // Replace with the actual command for uploading to TestFlight, e.g., using Fastlane or another tool
  result = await Process.run(
      'xcrun', ['altool', '--upload-app', '--type', 'ios', '--file', 'build/ios/ipa/*.ipa', '--apiKey', apiKey, '--apiIssuer', apiIssuer],
      workingDirectory: workingDirectory, runInShell: true
  );
  if (result.exitCode != 0) {
    handleError('Upload to TestFlight failed: ${result.stderr}');
  }

  print('iOS app uploaded to TestFlight successfully!');
  print('Time taken: ${DateTime.now().difference(startTime)}');
}
