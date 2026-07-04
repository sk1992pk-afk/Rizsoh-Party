import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizations {
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
    Locale('ur'),
  ];

  static const List<LocalizationsDelegate> localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const Map<String, Map<String, String>> localizedStrings = {
    'en': {
      'app_name': 'Rizsoh',
      'home': 'Home',
      'activity': 'Activity',
      'games': 'Games',
      'messages': 'Messages',
      'profile': 'Profile',
      'join_room': 'Join Room',
      'create_room': 'Create Room',
      'wallet': 'Wallet',
      'coins': 'Coins',
      'diamonds': 'Diamonds',
    },
    'ar': {
      'app_name': 'ريزسو',
      'home': 'الرئيسية',
      'activity': 'النشاط',
      'games': 'الألعاب',
      'messages': 'الرسائل',
      'profile': 'ملفي',
      'join_room': 'انضم إلى الغرفة',
      'create_room': 'إنشاء غرفة',
      'wallet': 'المحفظة',
      'coins': 'العملات',
      'diamonds': 'الماسات',
    },
    'ur': {
      'app_name': 'ریزسو',
      'home': 'ہوم',
      'activity': 'سرگرمی',
      'games': 'گیمز',
      'messages': 'پیغامات',
      'profile': 'پروفائل',
      'join_room': 'کمرے میں شامل ہوں',
      'create_room': 'کمرہ بنائیں',
      'wallet': 'والٹ',
      'coins': 'سکے',
      'diamonds': 'ہیرے',
    },
  };

  static String getString(String key, Locale locale) {
    final languageCode = locale.languageCode;
    return localizedStrings[languageCode]?[key] ?? key;
  }
}
