# Contributing to Wefter plugins

This repository manages all official Wefter device capability plugins. Each plugin is hosted in its own git repository and linked here as a git submodule.

## Code of conduct

Please review and adhere to the [code of conduct](https://github.com/Wefters/.github/blob/main/CODE_OF_CONDUCT.md).

## Submodule structure

To work with all plugin submodules locally:

```bash
git submodule update --init --recursive
```

To build all plugins:

```bash
./build-all.sh
```

## Plugin architecture

Every official Wefter plugin contains five components:

1. `plugin.json`: The manifest declaring the plugin identifier, callable methods, event hooks, Android permissions, Gradle dependencies, and iOS Info.plist keys.
2. `src/index.ts`: The TypeScript interface exporting a typed proxy object generated with `definePlugin` from `@wefterjs/core`.
3. `android/`: The native Kotlin implementation extending `WefterPlugin`. Methods exposed to JavaScript are annotated with `@WefterMethod`.
4. `ios/`: The native Swift implementation conforming to `WefterPlugin`. Methods exposed to JavaScript are marked with `@objc`.
5. `test/`: Vitest test suites mocking bridge behavior using `@wefterjs/core/testing`.

## Developing an existing plugin

To modify an existing plugin:

1. Navigate to the plugin directory (for example, `Plugins/Scanner`).
2. Create a branch inside that plugin repository:
   ```bash
   git checkout -b fix/scanner-camera-fallback
   ```
3. Implement your changes across TypeScript and native code.
4. Run tests in the plugin directory:
   ```bash
   pnpm test
   ```
5. Validate plugin manifest consistency using the CLI:
   ```bash
   wefter plugin validate .
   ```
6. Test interactively inside `Demo-App` to confirm runtime behavior on a real device.

## Authoring a new plugin

To propose and create a new official plugin:

1. Open a [new plugin proposal](.github/ISSUE_TEMPLATE/new_plugin_proposal.yml) on GitHub to discuss the API design and use case.
2. Scaffold a working plugin boilerplate using the CLI:
   ```bash
   wefter create-plugin my-plugin
   ```
3. Implement the native Kotlin and Swift classes.
4. Ensure both platforms handle error conditions gracefully by returning bridge errors with descriptive codes.
5. Write unit tests in `test/` verifying TypeScript types and bridge invocation payloads.
6. Write a comprehensive `README.md` documenting installation, methods, interfaces, events, and platform notes.
7. Run `wefter plugin validate` to confirm manifest compliance.

## Pull request process

1. If you are modifying an existing plugin, submit your pull request directly to that plugin repository (for example, `https://github.com/Wefters/Scanner`).
2. If you are adding a new plugin or updating submodule pointers in this aggregator repository, submit a pull request to `https://github.com/Wefters/Plugins`.
3. Fill out the pull request template completely and link related issues.

## License

All official plugins are released under the [MIT License](LICENSE).
