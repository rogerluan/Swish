import XCTest

@testable import Swish
import PathKit

final class SwishTests: XCTestCase {

    func testSh() {
        XCTAssertNoThrow(sh([ "echo", "Hello", "World" ]))
    }

    func testExecute() {
        XCTAssertNoThrow(execute(shellScript:
            """
            #!/bin/sh
            echo Hello World
            """, arguments: ""))
        XCTAssertNoThrow(execute(shellScript:
            """
            #!/bin/sh
            echo "$1 $2"
            """, arguments: "Roger that"))
        XCTAssertNoThrow(execute(shellScript:
            """
            #!/bin/sh
            echo "$1"
            """, arguments: #""Roger that""#))
    }

    func testFastlane() {
        XCTAssertNoThrow(try fastlane([ "test", "key:value", "key2:value2" ]))
    }

    func testBundleExec() {
        XCTAssertNoThrow(try bundleExec([ "fastlane", "deploy", "submit:false", "build_number:24" ]))
        XCTAssertNoThrow(try bundleExec([ "jazzy", "--clean", "--output", "docs/swift", "--theme", "fullwidth" ]))
    }

    func testPreferredBinaryPath() {
        // Note: this one can't be tested inside Xcode, because Xcode doesn't execute your shell environment profile (e.g. .bash_profile, .zshrc)
        XCTAssert(preferredBinaryPath(for: "bundler") == (Path.home + Path("/.rbenv/shims/bundler")), "bundler couldn't be found in PATH environment variable")
    }

    static var allTests = [
        ("testSh", testSh),
        ("testExecute", testExecute),
        ("testFastlane", testFastlane),
        ("testBundleExec", testBundleExec),
        ("testPreferredBinaryPath", testPreferredBinaryPath),
    ]
}
