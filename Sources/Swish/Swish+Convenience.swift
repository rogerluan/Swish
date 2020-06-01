// Copyright © 2020 Roger Oba. All rights reserved.

import Foundation
import PathKit

/// Executes fastlane, first attempting to execute it via *bundler* and, if not possible,
/// it looks for the fastlane binary installed globally in your system.
///
///     fastlane([ "[lane]", "key:value", "key2:value2" ])
///     fastlane([ "deploy", "submit:false", "build_number:24" ])
///
/// - Parameter arguments: The list of arguments to be passed to fastlane.
/// - Throws: This method throws if fastlane executable can't be found in your environment PATH.
public func fastlane(_ arguments: [String]) throws {
    do {
        try bundleExec([ "fastlane" ] + arguments)
    } catch {
        guard let fastlanePath = preferredBinaryPath(for: "fastlane") else { throw Error("fastlane not found in your system.") }
        execute(shellScript:
            """
            \(fastlanePath) "$@"
            """, arguments: arguments.joined(separator: " "))
    }
}

/// Executes "bundle exec" using the bundler executable indicated by your environment PATH variable.
///
///     bundleExec([ "fastlane", "deploy", "submit:false", "build_number:24" ])
///     bundleExec([ "jazzy", "--clean", "--output", "docs/swift", "--theme", "fullwidth" ])
///
/// - Parameter arguments: The list of arguments to be passed to bundler.
/// - Throws: This method throws if bundler executable can't be found in your environment PATH.
public func bundleExec(_ arguments: [String]) throws {
    guard let bundlerPath = preferredBinaryPath(for: "bundler") else { throw Error("bundler not found in your system.") }
    execute(shellScript:
        """
        \(bundlerPath) exec "$@"
        """, arguments: arguments.joined(separator: " "))
}

/// Helps find the path of an executable by looking at the *PATH* environment variable.
///
/// This is needed because *which `executable`* may not return the expected path if ran from a swift script,
/// because swift script's *Process* doesn't take the *PATH* environment variable into consideration.
///
///     sh(launchPath: "which", "bundler") // TODO
///     sh("which bundler") // TODO
///     preferredBinaryPath(for: "bundler") // $HOME/.rbenv/shims/bundler # An example, if you use rbenv.
///     preferredBinaryPath(for: "bundler") // $HOME/.rvm/scripts/rvm/bundler # An example, if you use rmv.
///
/// - Parameter executable: name of the executable being looked up. Example: bundler
/// - Returns: Returns the path of the most preferred binary for the given executable, or nil if it couldn't be found in the PATH.
internal func preferredBinaryPath(for executable: String) -> Path? {
    let paths: [Path] = ProcessInfo().environment["PATH"]!.components(separatedBy: ":").map { Path($0) }
    for path in paths {
        guard let children = try? path.children() else { continue }
        guard let result = children.first(where: { $0.lastComponent.contains(executable) }) else { continue }
        return result
    }
    return nil
}
