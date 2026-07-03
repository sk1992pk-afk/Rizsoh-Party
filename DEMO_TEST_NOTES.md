# MR BOSS v4.5 demo-safe notes

This package is focused on a polished first APK test experience:
- all 5 tabs open with demo data
- wallet, manager center, and live room have no-backend-safe demo screens
- live room does not crash if Agora is not configured
- navigation between Home -> Live Room, Me -> Wallet, Me -> Manager Center is wired

Build as before:
```bash
flutter clean
flutter pub get
flutter build apk --debug
```
