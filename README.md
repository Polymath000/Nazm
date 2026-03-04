# Nazm (نظم) - Minimalist To-Do & Calendar App

**Nazm** (Arabic for *Organization* or *Order*) is a feature-rich, beautiful, and minimalist Flutter application designed to help you organize your daily tasks and schedule with ease. Built with an "Offline First" philosophy, it ensures your productivity is never interrupted by connectivity issues.

---

## 📱 Screenshots

| Onboarding | Login | Sign Up |
|---|---|---|
| ![Onboarding](./readme_assets/fd55351e-9b7c-4e96-997e-3a5e9198079a) | ![Login](./readme_assets/de5ef889-6d3f-4995-a105-f492851b18c9) | ![Sign Up](./readme_assets/3d8ba284-223e-45f7-96e5-23d0ab7d5f56) |

| Tasks View | Calendar View | Settings |
|---|---|---|
| ![Tasks](./readme_assets/cae58bc9-f855-493f-97c7-ef322b18586b) | ![Calendar](./readme_assets/c811c620-ead9-4e66-a467-2accd8665b52) | ![Settings](./readme_assets/adc913b1-7348-4798-9015-6e74e21444cf) |

---

## ✨ Features

- **🚀 Offline-First:** Fast and reliable task management using Hive local database.
- **☁️ Cloud Sync:** Seamlessly sync your tasks across devices using Firebase Firestore.
- **📅 Visual Calendar:** View and manage your schedule with a clean month/week calendar view.
- **🌗 Adaptive Theme:** Sleek Light and Dark modes that adapt to your system settings.
- **🔒 Secure Auth:** Email/Password authentication and Google Sign-In support.
- **🔔 Notifications:** (Planned) Stay on top of your deadlines.
- **🎨 Premium UI:** Animated onboarding and smooth transitions with a curved navigation bar.

---

## 🛠️ Technology Stack

- **Framework:** [Flutter](https://flutter.dev/)
- **State Management:** [Flutter Bloc / Cubit](https://pub.dev/packages/flutter_bloc)
- **Local Database:** [Hive](https://pub.dev/packages/hive)
- **Backend:** [Firebase](https://firebase.google.com/) (Auth & Firestore)
- **Theming:** [Adaptive Theme](https://pub.dev/packages/adaptive_theme)
- **Calendar:** [Syncfusion Flutter Calendar](https://pub.dev/packages/syncfusion_flutter_calendar)
- **Icons & UI:** FontAwesome, Curved Navigation Bar

---

## � Project Structure

```text
lib/
├── core/               # Shared utilities, services, and base classes
├── Features/
│   ├── Auth/           # Login, Sign Up, and Password Management
│   ├── home/           # Main dashboard, Task Lists, Calender, and Tasks Logic
│   ├── onboarding/     # Initial user walkthrough screens
│   └── splash/         # App entry animations
├── constants.dart      # Global app constants and styles
└── main.dart           # App entry point and initialization
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Android Studio / VS Code
- Firebase Project (for sync features)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/nazm.git
   cd nazm
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase:**
   - Add your `google-services.json` (Android) to `android/app/`.
   - Add your `FirebaseOptions` to `lib/main.dart`.

4. **Run the app:**
   ```bash
   flutter run
   ```

---

## 📄 License

This project is for demonstration purposes. Feel free to use the code as a reference for your own productivity apps.

---
*Created with ❤️ by Abdelrahman*
