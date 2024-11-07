#!/usr/bin/env dart

import 'dart:convert';
import 'dart:io';
import 'package:googleapis/androidpublisher/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:yaml/yaml.dart';

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

  return configMap['android'];
}

void deploy() async {
  final workingDirectory = Directory.current.path;
  final config = await loadConfig(workingDirectory);
  final credentialsFile0 = config['credentialsFile'];
  final packageName = config['packageName'];
  final whatsNew = config['whatsNew'];

  DateTime startTime = DateTime.now();

  print('Clean the project');
  var result = await Process.run('flutter', ['clean'], workingDirectory: workingDirectory, runInShell: true);
  if (result.exitCode != 0) {
    print('flutter clean failed: ${result.stderr}');
    return;
  }

  print('Build app bundle');
  result = await Process.run('flutter', ['build', 'appbundle'], workingDirectory: workingDirectory, runInShell: true);
  if (result.exitCode != 0) {
    print('flutter build appbundle failed: ${result.stderr}');
    return;
  }
  print('App bundle built successfully');

  print('Get service account');
  File credentialsFile = File(credentialsFile0);
  final credentials = ServiceAccountCredentials.fromJson(json.decode(credentialsFile.readAsStringSync()));
  final httpClient = await clientViaServiceAccount(credentials, [AndroidPublisherApi.androidpublisherScope]);

  try {
    print('Get Edit ID');
    final androidPublisher = AndroidPublisherApi(httpClient);
    final insertEdit = await androidPublisher.edits.insert(AppEdit(), packageName);
    final editId = insertEdit.id!;
    print("Edit ID: $editId");

    print('Upload app bundle');
    final aabFile = File('$workingDirectory/build/app/outputs/bundle/release/app-release.aab');
    final media = Media(aabFile.openRead(), aabFile.lengthSync());
    final uploadResponse = await androidPublisher.edits.bundles.upload(packageName, editId, uploadMedia: media);
    print("Bundle version code: ${uploadResponse.versionCode}");

    print('Assign to internal track');
    final track = Track(
      track: 'internal',
      releases: [
        TrackRelease(
          name: 'Internal Test Release',
          status: 'completed',
          versionCodes: [uploadResponse.versionCode!.toString()],
          releaseNotes: [
            LocalizedText(
              language: 'en-US',
              text: whatsNew,
            ),
          ],
        ),
      ],
    );
    await androidPublisher.edits.tracks.update(track, packageName, editId, 'internal');
    print("Assigned bundle to internal track with release notes");

    await androidPublisher.edits.commit(packageName, editId);
    print("Edit committed, upload complete.");
  } catch (e) {
    print("Failed to upload to Play Console: $e");
  } finally {
    httpClient.close();
    print('Time taken: ${DateTime.now().difference(startTime)}');
  }
}
