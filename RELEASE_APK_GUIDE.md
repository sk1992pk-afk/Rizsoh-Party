# MR BOSS v4.3 — release APK guide

## 1) Debug build
From `mrboss_flutter_app/`:
```bash
flutter pub get
flutter build apk --debug
```

## 2) Prepare a release keystore
Generate a keystore:
```bash
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

Put the file here:
`mrboss_flutter_app/android/app/upload-keystore.jks`

Create:
`mrboss_flutter_app/android/key.properties`

Use this format:
```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=upload
storeFile=../app/upload-keystore.jks
```

## 3) Build release APK
```bash
flutter build apk --release
```

Output:
`build/app/outputs/flutter-apk/app-release.apk`

## 4) If backend is not running
The app UI will still open. Login, wallet, manager, and room actions that call APIs will require the backend.
