// Copyright © 2020 Roger Oba. All rights reserved.

// TODO: Explain why no default output reading was integrated into the sh() function. tl;dr: you probably don't want, or shouldn't want to read output from CLI.
// If you need to do it, it should be done in Swift (e.g. reading/parsing files, grepping/sedding around, manipulating text streams, etc. The problem with redirecting the stdout/err out of the Process() is that it doesn't work with streams of text (e.g. async methods that take time to process). By not overriding it, all the stdout prints nicely on the terminal. Maybe add an option to silent the output or silent errors.

import Foundation

/// Executes a command from a given launch path, passing the given arguments.
///
///     sh(launchPath: "/bin/zsh", arguments: [ "echo", "Hello", "World" ])
///
/// - Parameters:
///   - launchPath: the launch path for the command to be executed. If you're executing a bash
///   command, this is likely the path to your preferred shell, e.g. "/bin/zsh" or "/bin/bash".
///   which can often be found under your *PATH* environment variable as *SHELL*.
///   Defaults to "/bin/zsh", path of macOS 10.15 Catalina default shell, zsh.
///   - arguments: the arguments that will be passed to the process.
public func sh(launchPath: String = "/bin/zsh", _ arguments: [String]) {
    let task = Process()
    task.environment = ProcessInfo().environment
    task.launchPath = launchPath
    task.arguments = arguments
    task.launch()
    task.waitUntilExit()
}

/// Executes an arbitrary shell script.
///
/// Example 1 (simple):
///
///     execute(shellScript:
///         """
///         #!/bin/sh
///         echo Hello World
///         """, arguments: "")
///     // Hello World
///
/// Example 2 (with arguments):
///
///     execute(shellScript:
///         """
///         #!/bin/sh
///         echo "$1 $2"
///         """, arguments: "Roger that")
///     // Roger that
///
/// Example 3 (with quoted arguments):
///
///     execute(shellScript:
///         """
///         #!/bin/sh
///         echo "$1"
///         """, arguments: #""Roger that""#)
///     // Roger that
///
///
/// - Parameters:
///   - shellScript: shell script to be executed.
///   - arguments: all arguments to be passed to the script, as a single string.
public func execute(shellScript: String, arguments: String) {
    sh("echo \"\(shellScript)\" \(arguments) | sh")
}
