# MR BOSS v4.2 — APK buildable package

## 1) Install prerequisites
- Flutter SDK 3.22+ (or newer stable)
- Android Studio + Android SDK
- Java 17
- An Android emulator or USB Android phone

## 2) Start backend (optional for UI launch)
Open `mrboss_backend/`:
```bash
npm install
npm run dev
```

## 3) Configure Flutter
Open `mrboss_flutter_app/android/local.properties` and set:
```properties
sdk.dir=/YOUR/ANDROID/SDK/PATH
flutter.sdk=/YOUR/FLUTTER/SDK/PATH
```

## 4) Set API and Agora
Edit:
- `mrboss_flutter_app/lib/src/core/constants/app_constants.dart`
- backend `.env`

## 5) Build debug APK
From `mrboss_flutter_app/`:
```bash
flutter pub get
flutter build apk --debug
```

Output APK:
`build/app/outputs/flutter-apk/app-debug.apk`

## 6) Build release APK
```bash
flutter build apk --release
```

## Notes
- Current release build uses debug signing for convenience. Replace with your own keystore before store publishing.
- If Agora causes issues before adding real credentials, keep the room test limited or stub it temporarily.
