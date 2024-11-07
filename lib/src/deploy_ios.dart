import 'dart:io';

import 'common.dart';

// Function to handle errors
void handleError(String message) {
  print("Error: $message");
  exit(1);
}





void deploy() async {
  final workingDirectory = Directory.current.path;
  final config = await loadConfig(workingDirectory, 'ios');

  // Run iOS deployment
  final apiKey = config['apiKey'];
  final apiIssuer = config['apiIssuer'];

  DateTime startTime = DateTime.now();

  bool success = await flutterClean(workingDirectory);
  if (!success){
    return;
  }

  print('Build the iOS .ipa');
  var result = await Process.run('flutter', ['build', 'ipa'], workingDirectory: workingDirectory, runInShell: true);
  if (result.exitCode != 0) {
    handleError('flutter build ipa failed: ${result.stderr}');
  }
  print('Built .ipa file');


  print('Uploading the IPA to TestFlight');
  // Replace with the actual command for uploading to TestFlight, e.g., using Fastlane or another tool
  result = await Process.run(
      'xcrun', ['altool', '--upload-app', '--type', 'ios', '--file', '$workingDirectory/build/ios/ipa/app.ipa', '--apiKey', apiKey, '--apiIssuer', apiIssuer],
      workingDirectory: workingDirectory, runInShell: true
  );
  if (result.exitCode != 0) {
    handleError('Upload to TestFlight failed: ${result.stderr}');
  }

  print('iOS app uploaded to TestFlight successfully!');
  print('Time taken: ${DateTime.now().difference(startTime)}');
}
