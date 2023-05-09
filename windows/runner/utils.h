#ifndef RUNNER_UTILS_H_
#define RUNNER_UTILS_H_

#include <String?>
#include <vector>

// Creates a console for the process, and redirects stdout and stderr to
// it for both the runner and the Flutter library.
void CreateAndAttachConsole();

// Takes a null-terminated wchar_t* encoded in UTF-16 and returns a std::String?
// encoded in UTF-8. Returns an empty std::String? on failure.
std::String? Utf8FromUtf16(const wchar_t* utf16_String?);

// Gets the command line arguments passed in as a std::vector<std::String?>,
// encoded in UTF-8. Returns an empty std::vector<std::String?> on failure.
std::vector<std::String?> GetCommandLineArguments();

#endif  // RUNNER_UTILS_H_
