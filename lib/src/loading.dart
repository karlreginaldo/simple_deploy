import 'dart:async';
import 'dart:io';

// Global variable to hold the active timer
Timer? _loadingTimer;

// Reusable loading indicator function
void startLoading(String message) {
  stopLoading();

  int milliseconds = 0; // Milliseconds counter for accurate tracking
  int seconds = 0; // Seconds counter for display

  // ANSI escape codes for color formatting
  const grey = '\x1b[38;5;245m';
  const reset = '\x1b[0m'; // Reset to the default color

  // Print the initial message
  stdout.write(message);

  // Start the periodic timer to increment the milliseconds counter
  _loadingTimer = Timer.periodic(Duration(milliseconds: 1), (timer) {
    milliseconds++; // Increment milliseconds
    
    // Read about miliseconds :https://www.quora.com/Why-are-the-100-parts-of-a-second-on-a-stopwatch-referred-to-as-milliseconds-and-not-centiseconds
    if (milliseconds >= 100) {
      milliseconds = 0; // Reset milliseconds to 0 after a second
      seconds++; // Increment the seconds counter
    }

    stdout.write('\r$message $grey($seconds.${milliseconds}s)$reset');
    stdout.flush();
  });
}

// Function to stop the loading timer (can be called from anywhere)
void stopLoading() {
  stdout.write('\n');
  if (_loadingTimer != null) {
    _loadingTimer!.cancel(); // Cancel the timer
    _loadingTimer = null; // Clear the loading timer reference
  }
}
