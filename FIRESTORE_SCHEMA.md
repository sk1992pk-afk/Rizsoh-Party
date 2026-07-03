# Firestore Schema

## users/{uid}
displayName, avatarUrl, role, agencyId, followersCount, followingCount, likesCount, coins, diamonds, shippingCoins, wealthLevel, createdAt

## agencies/{agencyId}
name, bdId, adminId, revenue, diamondsTarget, activeGuilds, createdAt

## salaries/{salaryId}
userId, month, base, salary1, salary2, salary3, total, status

## rooms/{roomId}
hostId, title, coverUrl, type, live, viewerCount, rtcChannel, micSeats[], seatLock, createdAt

## room_messages/{messageId}
roomId, senderId, text, createdAt

## gifts/{giftId}
name, priceCoins, animationUrl

## gift_logs/{logId}
senderId, receiverId, roomId, giftId, quantity, createdAt

## withdrawals/{id}
userId, amount, method, status, createdAt
