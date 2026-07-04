# Rizsoh Backend API

Node.js backend for Rizsoh Gaming Platform with Manager Center, Payment Processing, and Tournament Management.

## Setup

```bash
cd backend
npm install
npm run dev
```

## Environment Variables

```env
PORT=3000
FIREBASE_PROJECT_ID=rizsoh-gaming-arena
FIREBASE_PRIVATE_KEY=your_key_here
FIREBASE_CLIENT_EMAIL=your_email@firebase.iam.gserviceaccount.com

# Payment APIs
TAPPAY_API_KEY=your_tappay_key
STRIPE_API_KEY=your_stripe_key
PAYTABS_API_KEY=your_paytabs_key

# Agora
AGORA_APP_ID=your_agora_app_id
AGORA_APP_CERTIFICATE=your_agora_certificate

# JWT
JWT_SECRET=your_jwt_secret
```

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user
- `POST /api/auth/refresh-token` - Refresh JWT token

### Manager Center
- `POST /api/manager/create-agency` - Create new agency
- `POST /api/manager/hire-member` - Hire team member
- `GET /api/manager/:userId/agency` - Get user's agency
- `GET /api/manager/:userId/salary/:month` - Get monthly salary
- `POST /api/manager/:userId/withdraw` - Withdraw salary
- `GET /api/manager/:agencyId/members` - Get agency members
- `POST /api/manager/update-role` - Update user role

### Rooms
- `POST /api/rooms/create` - Create new room
- `GET /api/rooms/live` - Get all live rooms
- `GET /api/rooms/:roomId` - Get room details
- `POST /api/rooms/:roomId/join` - Join room
- `POST /api/rooms/:roomId/leave` - Leave room
- `POST /api/rooms/:roomId/generate-token` - Get Agora token

### Wallet
- `GET /api/wallet/:userId/coins` - Get user coins
- `GET /api/wallet/:userId/diamonds` - Get user diamonds
- `POST /api/wallet/:userId/add-coins` - Add coins (admin)
- `POST /api/wallet/:userId/exchange` - Exchange diamonds for coins
- `POST /api/wallet/send-gift` - Send gift to another user

### Payments
- `POST /api/payment/tappay` - Process TapPay payment
- `POST /api/payment/stripe` - Process Stripe payment
- `POST /api/payment/paytabs` - Process PayTabs payment
- `GET /api/payment/packages` - Get payment packages

### Tournaments
- `POST /api/tournament/create` - Create tournament
- `GET /api/tournament/:tournamentId` - Get tournament details
- `POST /api/tournament/:tournamentId/join` - Join tournament
- `POST /api/tournament/:tournamentId/start` - Start tournament
- `POST /api/tournament/:tournamentId/end` - End tournament

## Database Collections

### users
```json
{
  "uid": "string",
  "name": "string",
  "email": "string",
  "role": "user|bd|admin|superAdmin",
  "coins": "number",
  "diamonds": "number",
  "agencyId": "string",
  "createdAt": "timestamp"
}
```

### rooms
```json
{
  "roomId": "string",
  "title": "string",
  "hostId": "string",
  "category": "casual|competitive|tournament|music|gaming",
  "status": "waiting|live|ended",
  "viewers": "number",
  "agoraRoomId": "string",
  "createdAt": "timestamp"
}
```

## License

MIT
