// Copyright © 2020 Roger Oba. All rights reserved.

/// Simpe error with a custom message.
public class Error : Swift.Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }
}
