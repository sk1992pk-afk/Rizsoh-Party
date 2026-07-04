# Rizsoh Admin Dashboard

React-based admin web dashboard for Rizsoh gaming platform. Manage users, managers, rooms, transactions, and analytics.

## Features

- 📊 Dashboard with key metrics
- 👥 User management and moderation
- 👔 Manager center and agency control
- 🎤 Room monitoring and control
- 💳 Transaction tracking
- 📈 Analytics and charts
- 🔐 Admin authentication

## Setup

```bash
cd admin
npm install
npm start
```

## Tech Stack

- React 18
- React Router v6
- Tailwind CSS
- Recharts for analytics
- Axios for API calls

## Environment Variables

```env
REACT_APP_API_URL=http://localhost:3000/api
REACT_APP_FIREBASE_CONFIG=your_firebase_config
```

## Pages

1. **Dashboard** - Overview of key metrics
2. **Users** - User list and moderation
3. **Managers** - Manager and agency management
4. **Rooms** - Live room monitoring
5. **Transactions** - Payment and transaction history
6. **Analytics** - Charts and statistics

## Deployment

```bash
npm run build
```

Deploy the `build` folder to Firebase Hosting or any static host.

## License

MIT
