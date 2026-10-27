# Repository Guidelines

## Project Structure & Module Organization

This is a Flutter portfolio app. `lib/main.dart` starts the app, and `lib/home_screen.dart` assembles the page. Keep portfolio copy and project data in `lib/content/`, data types in `lib/models/`, reusable UI in `lib/widgets/`, theme rules in `lib/theme/`, and platform helpers in `lib/core/`. Images live in `assets/brand/` and `assets/projects/`; web metadata, icons, and the downloadable CV live in `web/`. Tests belong in `test/`. The icon generation script is `tool/generate_web_icons.ps1`.

## Build, Test, and Development Commands

- `flutter pub get`: install dependencies declared in `pubspec.yaml`.
- `flutter run -d chrome`: run the portfolio locally in Chrome.
- `flutter build web`: produce the deployable site in `build/web/`.
- `flutter analyze`: check Dart code against `analysis_options.yaml`.
- `flutter test`: run the unit and widget tests.
- `dart format lib test`: format Dart source and tests.

Run these commands from the repository root. The project requires Dart SDK `^3.11.1` through a compatible Flutter installation.

## Coding Style & Naming Conventions

Use Dart's standard formatter and the `flutter_lints` rules enabled in `analysis_options.yaml`; do not hand-align code. Follow existing two-space indentation. Name Dart files and folders in `snake_case`, classes in `UpperCamelCase`, and variables and methods in `lowerCamelCase`. Keep page sections as focused widgets under `lib/widgets/`; update `PortfolioContent` when changing displayed project or profile data. Register new bundled assets in `pubspec.yaml`.

## Testing Guidelines

Use `flutter_test` for unit and widget tests. Name test files `*_test.dart` and place them under `test/`. Add tests for changed portfolio content or interactive UI behavior, including narrow layouts where relevant. The existing `test/portfolio_content_test.dart` shows both patterns. Run `flutter test` and `flutter analyze` before submitting changes. There is no stated coverage threshold.

## Commit & Pull Request Guidelines

The short Git history uses brief messages (`first version`, `v2`) and does not establish a formal convention. Write concise, descriptive imperative commit subjects, such as `Add project carousel controls`. In pull requests, describe the user-visible change, list verification commands, link any relevant issue, and include screenshots for visual or responsive layout changes.
