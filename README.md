# Wefter Plugins

Official Wefter plugins for native device functionality on Android and iOS, each maintained as its own repository and included here as a git submodule.

## Plugins

| Plugin | Package | Description |
| --- | --- | --- |
| [Biometric](https://github.com/Wefters/Biometric) | `@wefterjs/biometric` | Native biometric authentication (Face ID, Touch ID, Android BiometricPrompt) |
| [Browser](https://github.com/Wefters/Browser) | `@wefterjs/browser` | In-app web browsers via Android Custom Tabs and iOS `SFSafariViewController` |
| [Clipboard](https://github.com/Wefters/Clipboard) | `@wefterjs/clipboard` | Read/write the native system clipboard |
| [Device](https://github.com/Wefters/Device) | `@wefterjs/device` | Device metadata, unique ID, battery state, and system locale |
| [Dialog](https://github.com/Wefters/Dialog) | `@wefterjs/dialog` | Native alert, confirm, prompt, and toast dialogs |
| [FlashLight](https://github.com/Wefters/Flashlight) | `@wefterjs/flashlight` | Control the hardware camera LED flashlight/torch |
| [Haptics](https://github.com/Wefters/Haptics) | `@wefterjs/haptics` | Physical device haptic vibration feedback |
| [Network](https://github.com/Wefters/Network) | `@wefterjs/network` | Real-time connectivity status and network state changes |
| [Scanner](https://github.com/Wefters/Scanner) | `@wefterjs/scanner` | Camera QR code & barcode scanning |
| [Screen](https://github.com/Wefters/Screen) | `@wefterjs/screen` | Screen brightness, orientation locks, and keep-awake state |
| [SecureStorage](https://github.com/Wefters/SecureStorage) | `@wefterjs/secure-storage` | Hardware-backed encrypted storage (`EncryptedSharedPreferences`, Keychain) |
| [Share](https://github.com/Wefters/Share) | `@wefterjs/share` | Native share sheet |

## Getting the submodules

```sh
git submodule update --init --recursive
```

## License

MIT — see [LICENSE](./LICENSE).
