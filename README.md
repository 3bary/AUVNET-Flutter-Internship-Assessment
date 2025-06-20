# AUVNET Flutter Internship Assessment App

A **multi-screen Flutter application** demonstrating modern Flutter development practices:

* **Firebase Authentication** (email/password)
* **Firestore data retrieval**
* **BLoC state-management**
* **Responsive UI** with `flutter_screenutil`

The codebase is intentionally kept lightweight so you can focus on the architecture and state-management pattern rather than boiler-plate.

---

## ✨ Features

| Module | Description |
| ------ | ----------- |
| **Auth** | Log-in & sign-up with Firebase, form validation, loading indicators |
| **Home** | Landing page after successful authentication |
| **On-Boarding** | Example carousel to showcase the app |

> The application is structured feature-first – every high-level feature owns its **data / domain / presentation** layers.

---

## 🛠️ Installation & Setup

1. **Prerequisites**
   * Flutter 3.19+ (`flutter --version`)
   * A Firebase project (Email/Password auth enabled)
   * Android Studio / Xcode for platform tooling

2. **Clone the repo**
   ```bash
   git clone https://github.com/<your-org>/auvnet_app.git
   cd auvnet_app
   ```

3. **Install packages**
   ```bash
   flutter pub get
   ```

4. **Configure Firebase**

   Platform | File | Where to place
   -------- | ---- | --------------
   Android  | `android/app/google-services.json` | `android/app` folder
   iOS      | `ios/Runner/GoogleService-Info.plist` | Xcode → Runner target → *Add files*

   Then run:
   ```bash
   flutterfire configure # optional helper
   flutter run
   ```

> The project already includes `firebase_core`, `firebase_auth`, and `cloud_firestore` dependencies declared in `pubspec.yaml`.

---

## 📁 Folder Structure & Architecture

```
lib/
 ├── core/                 # App-wide utilities (constants, assets helper …)
 ├── features/
 │   ├── auth/
 │   │    ├── data/        # (left minimal – Firebase does the heavy lifting)
 │   │    ├── domain/      # Entities / repositories (future-proof)
 │   │    └── presentation/
 │   │         ├── views/  # Screens (LoginView, SignUpView, HomeView …)
 │   │         │     └── widgets/  # Shared UI components (AuthButton, AuthInputField …)
 │   │         └── view_model/    # BLoC + events + states
 │   └── home/
 │        └── presentation/
 └── main.dart             # App entry, routes, Firebase init
```

### Layer Rationale

| Layer | Purpose |
| ----- | ------- |
| **presentation/views** | Pure UI widgets; depend only on Flutter SDK & their respective BLoCs |
| **presentation/view_model** | BLoC classes (e.g. `AuthBloc`) orchestrate calls to Firebase and emit reactive states |
| **domain** | (Currently minimal) – would hold pure dart business logic, making testing easier |
| **data** | Firebase integration. For larger apps you might introduce repositories & local caches here |

This **clean-architecture-lite** approach keeps dependencies flowing one-way (UI → BLoC → Data) enabling easier testing and future expansion.

---

## 🎨 UI & Responsiveness

* `flutter_screenutil` enables px-to-dp conversions and dynamic sizing (`16.h`, `24.w`) so the design scales across devices.
* Common components (`AuthButton`, `AuthInputField`) live in one place and are reused in both login & signup flows.
* Each view’s heavy UI logic is extracted into a dedicated **Body** widget (`LoginViewBody`, `SignupViewBody`) to keep screen files lean.

---

## 🗂️ State-Management (BLoC)

* `AuthBloc` exposes:
  * `AuthLoginRequested`, `AuthSignupRequested` events
  * `AuthState` with `loading / authenticated / failure` statuses
* UI listens with `BlocListener` / `BlocBuilder` for minimal rebuilding

Why BLoC?

* Clear separation between UI & business logic
* Testable pure-dart classes
* Streams make it trivial to reflect real-time auth changes

---

## 🔐 Security Notes

* Tokens are cached automatically by Firebase Auth.
* **Never** commit your `google-services.json` or `GoogleService-Info.plist` with production keys.
* Consider `flutter_secure_storage` if you need to store additional sensitive info.

---

## 🚀 Running & Testing

```bash
# hot-reload during development
flutter run -d chrome   # or ios / android

# run unit tests (none yet but structure ready)
flutter test
```

---

## 🤝 Contributing

1. Fork the repo
2. Create a branch (`git checkout -b feature/your_feature`)
3. Commit your changes
4. Open a PR

---

## 📜 License

MIT © AUVNET
