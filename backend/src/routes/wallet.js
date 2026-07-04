const express = require('express');
const admin = require('firebase-admin');
const router = express.Router();

const db = admin.firestore();

// Get user coins
router.get('/:userId/coins', async (req, res) => {
  try {
    const { userId } = req.params;

    const userDoc = await db.collection('users').doc(userId).get();
    const coins = userDoc.data()?.coins || 0;

    res.json({
      success: true,
      coins,
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get user diamonds
router.get('/:userId/diamonds', async (req, res) => {
  try {
    const { userId } = req.params;

    const userDoc = await db.collection('users').doc(userId).get();
    const diamonds = userDoc.data()?.diamonds || 0;

    res.json({
      success: true,
      diamonds,
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Add coins (admin only)
router.post('/:userId/add-coins', async (req, res) => {
  try {
    const { userId } = req.params;
    const { amount } = req.body;

    await db.collection('users').doc(userId).update({
      coins: admin.firestore.FieldValue.increment(amount),
    });

    // Log transaction
    await db.collection('transactions').add({
      userId,
      type: 'reward',
      status: 'completed',
      amount,
      currencyType: 'coins',
      createdAt: new Date(),
    });

    res.json({
      success: true,
      message: `Added ${amount} coins`,
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Exchange diamonds for coins
router.post('/:userId/exchange', async (req, res) => {
  try {
    const { userId } = req.params;
    const { diamonds } = req.body;

    const userDoc = await db.collection('users').doc(userId).get();
    const currentDiamonds = userDoc.data()?.diamonds || 0;

    if (currentDiamonds < diamonds) {
      return res.status(400).json({ error: 'Insufficient diamonds' });
    }

    const coins = Math.floor(diamonds * 0.04); // 100 diamonds = 4 coins

    await db.collection('users').doc(userId).update({
      diamonds: admin.firestore.FieldValue.increment(-diamonds),
      coins: admin.firestore.FieldValue.increment(coins),
    });

    // Log transaction
    await db.collection('transactions').add({
      userId,
      type: 'exchange',
      status: 'completed',
      amount: diamonds,
      currencyType: 'diamonds',
      description: `Exchanged ${diamonds} diamonds for ${coins} coins`,
      createdAt: new Date(),
    });

    res.json({
      success: true,
      message: `Exchanged ${diamonds} diamonds for ${coins} coins`,
      coins,
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Send gift
router.post('/send-gift', async (req, res) => {
  try {
    const { senderId, receiverId, giftId, cost } = req.body;

    const senderDoc = await db.collection('users').doc(senderId).get();
    const senderCoins = senderDoc.data()?.coins || 0;

    if (senderCoins < cost) {
      return res.status(400).json({ error: 'Insufficient coins' });
    }

    const receiverReward = Math.floor(cost * 0.7); // Receiver gets 70%

    // Deduct from sender
    await db.collection('users').doc(senderId).update({
      coins: admin.firestore.FieldValue.increment(-cost),
    });

    // Add to receiver
    await db.collection('users').doc(receiverId).update({
      coins: admin.firestore.FieldValue.increment(receiverReward),
    });

    // Log transactions
    await db.collection('transactions').add({
      userId: senderId,
      type: 'gift',
      status: 'completed',
      amount: cost,
      currencyType: 'coins',
      relatedItemId: giftId,
      description: `Sent gift to ${receiverId}`,
      createdAt: new Date(),
    });

    res.json({
      success: true,
      message: 'Gift sent successfully',
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

module.exports = router;
