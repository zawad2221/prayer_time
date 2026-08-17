# Prayer Time App

A modern, high-precision Islamic Prayer Times application built with Flutter.

## ✨ Features

- **Precise Calculations**: Uses the `adhan` library for accurate prayer time data.
- **Swipable Interface**: Smoothly swipe between days to view past or future prayer times.
- **Dynamic Highlighting**: Automatically highlights the current and next prayer for today's date.
- **Bottom Navigation**: Easy switching between the Home view and Settings.
- **Custom Theming**: 
  - Supports **Light**, **Dark**, and **System Default** modes.
  - Consistent color palette using custom `AppColors` extension.
- **Configurable Settings**: 
  - Choose between **Hanafi** and **Shafi/Others** Asr calculation methods.
  - Persistent settings using `shared_preferences`.
- **Quick Navigation**: "Go to Today" button to quickly jump back to the current day.

## 🛠️ Technical Stack

- **Framework**: [Flutter](https://flutter.dev)
- **State Management**: `ValueNotifier` for reactive theme and settings updates.
- **Libraries**:
  - `adhan`: For Islamic prayer time calculations.
  - `intl`: For date and time formatting.
  - `shared_preferences`: For local settings persistence.
- **Architecture**: Clean separation of concerns with dedicated folders for models, services, widgets, and screens.

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable version recommended)
- Android Studio / VS Code
- A connected device or emulator

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/zawad2221/prayer_time.git
    ```
2.  **Navigate to the project folder**:
    ```bash
    cd prayer_time
    ```
3.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
4.  **Run the application**:
    ```bash
    flutter run
    ```

## 📐 Project Structure

```text
lib/
├── core/
│   ├── extensions/    # Context and UI extensions
│   └── theme/         # AppColors, AppSpacing, and AppTheme
├── models/            # Data models (Prayer, AppTheme, etc.)
├── notifiers/         # ValueNotifiers for global state
├── screens/           # Main screen widgets (Home, Settings)
├── services/          # Business logic (Prayer calculation, Persistence)
└── widgets/           # Reusable UI components (PrayerCard, SettingsView)
```

## 📝 License

Distributed under the MIT License.

---
Built with ❤️ by [zawad hossain](https://github.com/zawad2221)
