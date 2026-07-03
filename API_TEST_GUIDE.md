# MR BOSS Backend v4 test guide

## Run
```bash
npm install
npm run dev
```

## Login
POST `/api/auth/mock-login`
```json
{"role":"super_admin"}
```

Use the token in `Authorization: Bearer TOKEN`

## Core endpoints
- GET `/api/users/me`
- GET `/api/wallet/me`
- POST `/api/wallet/recharge`
- POST `/api/wallet/exchange`
- GET `/api/agencies`
- GET `/api/manager/dashboard`
- POST `/api/manager/salary/withdraw`
- POST `/api/rooms/create`
- POST `/api/rooms/join`
- GET `/api/gifts`
- POST `/api/gifts/send`
- POST `/api/payments/recharge-order`
- GET `/api/notifications/me`
