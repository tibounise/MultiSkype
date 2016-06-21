#include "Cocoa/Cocoa.h"

int main(int argc, const char *argv[]) {
  NSAutoreleasePool *pool  = [[NSAutoreleasePool alloc] init];

  [NSApplication sharedApplication];

  NSFileManager *fileManager = [NSFileManager defaultManager];
  
  // Skype uses a .pid file to check if it is already launched
  // This filed is stored at ~/Library/Application Support/Skype/Skype.pid
  NSString *pidFilePath = @"~/Library/Application Support/Skype/Skype.pid";
  NSString *pidFilePathExpanded = [pidFilePath stringByExpandingTildeInPath];
  BOOL pidFileExists = [fileManager fileExistsAtPath:pidFilePathExpanded];

  // if it exists, delete it
  if (pidFileExists == YES) {
    NSError *pidDeletionError = nil;
    BOOL pidDeletionSuccess = [fileManager removeItemAtPath:pidFilePathExpanded error:&pidDeletionError];

    // if Skype.pid file deletion fails show an alert message
    if (!pidDeletionSuccess) {
      NSLog(@"Skype.pid file deletion failed");
      [NSApp presentError:pidDeletionError];

      return -1;
    }
  }

  NSWorkspace *workspace = [NSWorkspace sharedWorkspace];
  NSString *skypePath = [workspace fullPathForApplication:@"Skype"];
  
  [workspace launchApplicationAtURL: [NSURL URLWithString:skypePath]
    options: NSWorkspaceLaunchDefault|NSWorkspaceLaunchNewInstance
    configuration: nil
    error: nil];
  
  [pool drain];
  
  return EXIT_SUCCESS;
}
