# Rizsoh - Group Voice Chat & Gaming Arena

A Flutter-based social gaming platform with integrated voice chat, skill-based matchmaking, and a creator economy model.

## Features

### Core Functionality
- **Live Voice Rooms**: Real-time group voice chat using Agora RTC
- **Gaming Integration**: In-room mini-games (WorldCup, Ludo, Carrom, UNO, etc.)
- **Skill-Based Matching**: Auto-create rooms based on skill level
- **Creator Guilds**: Host and monetize tournaments
- **Multi-Language Support**: English, Arabic, Urdu with RTL support

### UI/UX
- Gaming-focused dark theme with gold accents
- Glassmorphism cards with neon borders
- Luxury purple + gold gradient
- 5-tab bottom navigation: Home, Activity, Games, Messages, Profile

### Economy System
- **Coins**: Primary currency for gifts and items
- **Diamonds**: Premium currency for special rewards
- **Wallet Management**: Send, receive, exchange currencies
- **Mall System**: Buy and send gifts to other players
- **Payment Integration**: TapPay, Stripe, PayTabs (AED)

### Manager Center
- **Role-Based Access**: Super Admin, Admin, BD (Business Developer)
- **Team Management**: Hire, manage, and promote team members
- **Salary System**: Base salary + commission tiers
- **Performance Tracking**: Weekly rewards and metrics

## Tech Stack

- **Frontend**: Flutter 3.22+
- **State Management**: Riverpod
- **Navigation**: GoRouter
- **Voice/Video**: Agora RTC SDK
- **Backend**: Firebase (Auth, Firestore, Cloud Functions)
- **API**: Node.js for manager logic
- **Payments**: TapPay, Stripe, PayTabs
- **Database**: Firestore

## Project Structure

```
lib/
├── config/
│   ├── firebase_options.dart
│   ├── theme/
│   │   └── app_theme.dart
│   └── localization/
│       └── app_localizations.dart
├── features/
│   ├── home/
│   ├── activity/
│   ├── games/
│   ├── messages/
│   ├── profile/
│   ├── auth/
│   └── room/
├── routes/
│   └── app_router.dart
└── main.dart
```

## Getting Started

### Prerequisites
- Flutter 3.22+
- Android SDK (for Android build)
- Xcode (for iOS build)
- Firebase project
- Agora account

### Installation

1. Clone the repository
```bash
git clone https://github.com/sk1992pk-afk/Rizsoh-Party.git
cd Rizsoh-Party
```

2. Install dependencies
```bash
flutter pub get
```

3. Configure Firebase
- Add your Firebase credentials in `lib/config/firebase_options.dart`

4. Configure Agora
- Add your Agora App ID to the project

5. Run the app
```bash
flutter run
```

## Firebase Setup

### Firestore Collections

```javascript
// users
{
  uid: string,
  name: string,
  email: string,
  role: 'user' | 'admin' | 'bd' | 'super_admin',
  coins: number,
  diamonds: number,
  level: number,
  agencyId: string,
  profileImage: string,
  createdAt: timestamp,
}

// rooms
{
  roomId: string,
  title: string,
  hostId: string,
  category: string,
  viewers: number,
  maxMics: number,
  activeMics: string[],
  coverUrl: string,
  isLive: boolean,
  createdAt: timestamp,
}

// agencies
{
  agencyId: string,
  bdId: string,
  name: string,
  revenue: number,
  members: string[],
  level: number,
  createdAt: timestamp,
}

// salaries
{
  userId: string,
  month: string,
  base: number,
  salary1: number,
  salary2: number,
  salary3: number,
  total: number,
  withdrawn: boolean,
  withdrawnAt: timestamp,
}

// gifts
{
  giftId: string,
  name: string,
  coinPrice: number,
  diamondPrice: number,
  image: string,
  category: string,
}
```

## API Endpoints (Node.js)

```
POST /api/manager/hire-member
POST /api/manager/create-agency
GET /api/manager/:userId/salary
POST /api/manager/:userId/withdraw
POST /api/tournament/create
GET /api/tournament/join/:tournamentId
```

## Security Rules (Firestore)

See `firestore.rules` for security configurations.

## Multi-Language Support

- English (en)
- Arabic (ar) - RTL
- Urdu (ur) - RTL

## Payment Integration

- **TapPay**: UAE AED currency
- **Stripe**: International payments
- **PayTabs**: Middle East focus

## Deployment

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## Contributing

Contributions are welcome! Please create a feature branch and submit a pull request.

## License

MIT License - see LICENSE file for details

## Support

For support, email: support@rizsoh.app

## Authors

- Development: sk1992pk-afk
- Design & Strategy: Rizsoh Team

---

**Rizsoh - Where Gaming Meets Community** 🎮✨
