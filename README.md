# Wefter plugins

Official Wefter plugins for native device functionality on Android and iOS. Each plugin is maintained as its own repository and included in this repository as a git submodule.

## Official plugins

| Plugin                                                    | Package                    | Description                                                                                   |
| --------------------------------------------------------- | -------------------------- | --------------------------------------------------------------------------------------------- |
| [App](https://github.com/Wefters/App)                     | `@wefterjs/app`            | App lifecycle, deep links, back button handling, memory pressure warnings, and build metadata |
| [Biometric](https://github.com/Wefters/Biometric)         | `@wefterjs/biometric`      | Native biometric authentication (Face ID, Touch ID, Android BiometricPrompt)                  |
| [Browser](https://github.com/Wefters/Browser)             | `@wefterjs/browser`        | In-app web browsers via Android Custom Tabs and iOS SFSafariViewController, plus OAuth flows  |
| [Clipboard](https://github.com/Wefters/Clipboard)         | `@wefterjs/clipboard`      | Read, write, and clear operations for the native system clipboard                             |
| [Device](https://github.com/Wefters/Device)               | `@wefterjs/device`         | Device metadata, hardware identifier, battery status, charging updates, and system locale     |
| [Dialog](https://github.com/Wefters/Dialog)               | `@wefterjs/dialog`         | Native alert, confirm, prompt, and toast dialogs                                              |
| [ErrorTest](https://github.com/Wefters/ErrorTest)         | `@wefterjs/error-test`     | Diagnostic harness for verifying native bridge error handling and exception propagation       |
| [FlashLight](https://github.com/Wefters/Flashlight)       | `@wefterjs/flash-light`    | Hardware camera LED flashlight controls and state inspection                                  |
| [Haptics](https://github.com/Wefters/Haptics)             | `@wefterjs/haptics`        | Physical vibration patterns, impact haptics, and selection feedback                           |
| [Network](https://github.com/Wefters/Network)             | `@wefterjs/network`        | Real-time network status inspection and connection state change listeners                     |
| [Scanner](https://github.com/Wefters/Scanner)             | `@wefterjs/scanner`        | Camera QR code and barcode scanning with gallery image fallback                               |
| [Screen](https://github.com/Wefters/Screen)               | `@wefterjs/screen`         | Display brightness, orientation locking, and keep-awake controls                              |
| [SecureStorage](https://github.com/Wefters/SecureStorage) | `@wefterjs/secure-storage` | Hardware-backed encrypted key-value storage via Android Keystore and iOS Keychain             |
| [Share](https://github.com/Wefters/Share)                 | `@wefterjs/share`          | Native system share sheets for text, URLs, and files                                          |
| [Storage](https://github.com/Wefters/Storage)             | `@wefterjs/storage`        | Fast unencrypted key-value storage using SharedPreferences and UserDefaults                   |

## Managing submodules

To initialize and pull the latest code for all submodules:

```sh
git submodule update --init --recursive
```

To build all plugins in sequence:

```sh
./build-all.sh
```

## Plugin architecture

Every official plugin follows a uniform layout:

- `plugin.json`: Plugin manifest defining the plugin name, methods, hooks, Android permissions, and iOS Info.plist descriptions.
- `src/`: TypeScript wrapper defining typed helper objects, interfaces, and event subscription wrappers.
- `android/`: Native Kotlin implementation extending `WefterPlugin`.
- `ios/`: Native Swift implementation conforming to `WefterPlugin`.
- `test/`: Vitest test suites executing against mocked bridge environments.

## License

All plugins are released under the MIT license. See [LICENSE](./LICENSE) for details.
