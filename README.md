# Nazm — Task Manager

> **Organize your life, one task at a time.**

https://github.com/user-attachments/assets/video.mp4

[▶ Watch demo video](./video.mp4)

---

## 📱 What is Nazm?

**Nazm** is a full-featured, cross-platform task management (To-Do) app built with Flutter. It combines a beautiful animated onboarding experience, Firebase-backed authentication, and offline-first local storage via Hive — giving users a seamless experience whether they're online or offline.

The app lets you add, manage, and track tasks with due dates, priorities, and smart views that filter tasks by day, including today, tomorrow, the next 7 days, overdue, and completed.

---

## ✨ Features

### 🔐 Authentication
- **Email & Password** sign-up and login via Firebase Auth
- **Google Sign-In** with one tap
- **Guest mode** — use the app without creating an account
- Forgot password flow
- Account deletion from settings

### ✅ Task Management
- Add tasks with a **title**, **description**, **due date**, and **priority level** (High / Medium / Low / No Priority)
- Mark tasks as done with a satisfying completion sound (`audioplayers`)
- Edit or delete tasks inline
- Priority shown with color-coded badges per light/dark theme

### 📅 Task Views (via Drawer)
| View | Description |
|---|---|
| **All Tasks** | Every task in the list |
| **Today** | Tasks due today |
| **Tomorrow** | Tasks due tomorrow |
| **Next 7 Days** | Upcoming tasks for the week |
| **Overdue** | Past-due tasks |
| **Completed** | Finished tasks |

### 🗓️ Calendar View
- Interactive calendar (Syncfusion) switchable between **Week** and **Month** views
- Tap a date to pre-fill the due date when adding a new task

### 🌗 Themes
- **Light**, **Dark**, and **System** modes, switchable from Settings
- Theme preference is persisted across sessions (`adaptive_theme`)

### ☁️ Cloud Sync
- If signed in, task completion status syncs to **Cloud Firestore** in real time
- Offline tasks are always available via **Hive** local storage

### 🎨 Onboarding
- Beautiful animated onboarding screens (`gif_view`) with page indicators and skip support

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| **Framework** | Flutter (Dart) |
| **State Management** | BLoC / Cubit (`flutter_bloc`) |
| **Local Storage** | Hive (`hive`, `hive_flutter`) |
| **Cloud Backend** | Firebase Firestore |
| **Authentication** | Firebase Auth + Google Sign-In |
| **Calendar** | Syncfusion Flutter Calendar & DatePicker |
| **Audio** | `audioplayers` (task completion sound) |
| **Connectivity** | `internet_connection_checker` |
| **Theming** | `adaptive_theme` (Light / Dark / System) |
| **Navigation** | `curved_navigation_bar` |
| **Animations** | `gif_view`, `loading_animation_widget` |
| **UI** | Material 3, `flutter_svg`, `font_awesome_flutter` |

---

## 🗂️ Project Structure

```
lib/
├── Features/
│   ├── Auth/                  # Login, Sign-up, Google Auth, Forgot Password
│   ├── home/                  # Tasks view, Calendar view, Add/Edit task
│   │   ├── data/              # TaskModel (Hive), TaskCubit, AddTaskCubit
│   │   └── presentation/
│   │       └── views/
│   │           ├── ViewsInTasksViews/   # Today, Tomorrow, 7Days, Overdue, Completed, All
│   │           ├── calender_view.dart
│   │           ├── home_view.dart       # Bottom nav host
│   │           ├── tasks_view.dart      # Drawer + task list host
│   │           └── settings.dart        # Theme toggle, Sign out, Delete account
│   └── onboarding/            # Animated onboarding screens
├── constants.dart             # App-wide constants & helpers (isOverdue, colors, etc.)
├── firebase_options.dart      # Generated Firebase config
└── main.dart                  # App entry — Firebase, Hive, AdaptiveTheme init
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `^3.5.0`
- Android SDK / Xcode (for mobile builds)
- A Firebase project with Firestore and Authentication enabled
- `google-services.json` placed in `android/app/`

### Run

```bash
flutter pub get
flutter run
```

### Build APK

```bash
flutter build apk --release
```

---

## 📦 Key Dependencies

```yaml
flutter_bloc: ^9.0.0          # State management
hive: ^2.2.3                  # Local offline storage
hive_flutter: ^1.1.0
firebase_core: ^3.6.0         # Firebase
cloud_firestore: ^5.6.6       # Cloud sync
firebase_auth: ^5.3.1         # Authentication
google_sign_in: ^6.2.1        # Google OAuth
syncfusion_flutter_calendar: ^28.1.1   # Calendar widget
audioplayers: ^6.2.0          # Completion sound
adaptive_theme: ^3.6.0        # Theme persistence
curved_navigation_bar: ^1.0.6 # Bottom nav
internet_connection_checker: ^3.0.1
```

---

## 📸 Screenshots & Demo

> See `video.mp4` in the root of this repository for a full walkthrough of the app.

---

## 📄 License

This project is for personal/educational use. All rights reserved © Abdelrahman Khaled.
