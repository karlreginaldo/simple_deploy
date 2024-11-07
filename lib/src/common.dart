import 'dart:io';

import 'package:yaml/yaml.dart';

// Load configuration from a YAML file
Future<YamlMap> loadConfig(String workingDirectory, String section) async {
  final configFile = File('$workingDirectory/deploy.yaml');
  final configContent = await configFile.readAsString();
  final yamlMap = loadYaml(configContent);

  // Manually convert YamlMap to Map<String, dynamic>
  final Map<String, dynamic> configMap = {};
  for (var key in yamlMap.keys) {
    configMap[key] = yamlMap[key];
  }
  return configMap[section];
}

Future<bool> flutterClean(String workingDirectory) async{
  print('Clean the project');
  var result = await Process.run('flutter', ['clean'], workingDirectory: workingDirectory, runInShell: true);
  if (result.exitCode != 0) {
    print('flutter clean failed: ${result.stderr}');
    return false;
  }
  return true;
}