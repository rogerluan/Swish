// Copyright © 2020 Roger Oba. All rights reserved.

/// Executes a command from a given launch path.
///
///     sh(launchPath: "/bin/zsh", command: "echo Hello World")
///
/// - Parameters:
///   - launchPath: the launch path for the command to be executed. If you're executing a bash
///   command, this is likely the path to your preferred shell, e.g. "/bin/zsh" or "/bin/bash".
///   Defaults to "/bin/zsh", path of macOS 10.15 Catalina default shell, zsh.
///   - command: the command to be executed.
public func sh(launchPath: String = "/bin/zsh", _ command: String) {
    sh(launchPath: launchPath, [ "-c", command ])
}

/// Executes a command from a given launch path, passing the given arguments.
///
///     sh(launchPath: "/bin/zsh", arguments: "echo", "Hello", "World")
///
/// - Parameters:
///   - launchPath: the launch path for the command to be executed. If you're executing a bash
///   command, this is likely the path to your preferred shell, e.g. "/bin/zsh" or "/bin/bash".
///   Defaults to "/bin/zsh", path of macOS 10.15 Catalina default shell, zsh.
///   - arguments: the arguments that will be passed to the process.
public func sh(launchPath: String = "/bin/zsh", _ arguments: String...) {
    sh(launchPath: launchPath, arguments)
}

/// Executes fastlane, first attempting to execute it via *bundler* and, if not possible,
/// it looks for the fastlane binary installed globally in your system.
///
///     fastlane("[lane]]", "key:value", "key2:value2")
///     fastlane("deploy", "submit:false", "build_number:24")
///
/// - Parameter arguments: The list of arguments to be passed to fastlane.
/// - Throws: This method throws if fastlane executable can't be found in your environment PATH.
public func fastlane(_ arguments: String...) throws {
    try fastlane(arguments)
}

/// Executes "bundle exec" using the bundler executable indicated by your environment PATH variable.
///
///     bundleExec("fastlane", "deploy", "submit:false", "build_number:24")
///     bundleExec("jazzy", "--clean", "--output", "docs/swift", "--theme", "fullwidth")
///
/// - Parameter arguments: The list of arguments to be passed to bundler.
/// - Throws: This method throws if bundler executable can't be found in your environment PATH.
public func bundleExec(_ arguments: String...) throws {
    try bundleExec(arguments)
}
