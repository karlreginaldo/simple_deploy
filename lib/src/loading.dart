import 'dart:async';
import 'dart:io';

Timer? _loadingTimer; // Timer reference to control the animation cycle

void startLoading(String message) {
  stopLoading(); // Stop any existing loading animation first

  int frameIndex = 0; // Index to cycle through the frames "|", "\", "/", "-"

  // The frames for the animation
  const frames = ['|', '\\', '/', '-'];

  // ANSI escape codes for color formatting
  const grey = '\x1b[38;5;245m';
  const reset = '\x1b[0m'; // Reset to the default color

  // Print the initial message
  stdout.write(message);

  // Start the periodic timer to animate the rotating symbol
  _loadingTimer = Timer.periodic(Duration(milliseconds: 250), (timer) {
    String currentFrame = frames[frameIndex]; // Get the current frame

    stdout.write(
        '\r$message $grey$currentFrame$reset'); // Update the animation frame
    stdout.flush();

    // Cycle to the next frame
    frameIndex = (frameIndex + 1) % frames.length;
  });
}

// Function to stop the loading timer (can be called from anywhere)
void stopLoading() {
  stdout.write('\n'); // Move to a new line after the loading is stopped
  if (_loadingTimer != null) {
    _loadingTimer!.cancel(); // Cancel the timer
    _loadingTimer = null; // Clear the loading timer reference
  }
}
