# Swish - Swift Shell
##### Execute shell scripts from your Swift scripts.

If you've been into scripting in Swift for awhile, you noticed that you can get rid of most of the basic shell scripting commands, but sometimes you still need to access certain shell commands, or want to create wrappers around CLI such as fastlane and bundler.

This package solves the issues where your Swift script can't find the same executables as your regular shell.

## Usage

#### Single Command

```swift
sh(launchPath: "/bin/zsh", arguments: "echo", "Hello", "World")
```

#### Full script

###### With no arguments

```swift
execute(shellScript:
    """
    #!/bin/sh
    echo Hello World
    """, arguments: "")
// Hello World
```

###### With arguments

```swift
execute(shellScript:
    """
    #!/bin/sh
    echo "$1 $2"
    """, arguments: "Roger that")
// Roger that
```

###### Quoted arguments

```swift
execute(shellScript:
    """
    #!/bin/sh
    echo "$1"
    """, arguments: #""Roger that""#)
// Roger that
```

#### Fastlane

Executes fastlane, first attempting to execute it via `bundler` and, if not possible, it looks for the fastlane binary installed globally in your system by looking up the `PATH` environment variable.

```swift
fastlane("[lane]", "key:value", "key2:value2")
```

```swift
fastlane("deploy", "submit:false", "build_number:24")
```

#### Bundler

Executes `bundle exec` using the bundler executable indicated by your environment `PATH` variable.

```swift
bundleExec("fastlane", "deploy", "submit:false", "build_number:24")
```

```swift
bundleExec("jazzy", "--clean", "--output", "docs/swift", "--theme", "fullwidth")
```

## Contact

[@rogerluan_](https://twitter.com/rogerluan_)

## License

_Swish_ is licensed under a standard [2-clause BSD License](LICENSE). That means you have to mention **Roger Oba** as the original author of this code and reproduce the LICENSE text inside your app.
