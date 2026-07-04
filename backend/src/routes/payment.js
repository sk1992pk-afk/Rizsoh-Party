const express = require('express');
const admin = require('firebase-admin');
const axios = require('axios');
const router = express.Router();

const db = admin.firestore();

// Get payment packages
router.get('/packages', async (req, res) => {
  try {
    const packages = [
      { packageId: '1', coins: 9000, priceAED: 3.79, bonus: 900 },
      { packageId: '2', coins: 45500, priceAED: 18.89, bonus: 5000 },
      { packageId: '3', coins: 91000, priceAED: 38.89, bonus: 10000 },
      { packageId: '4', coins: 183000, priceAED: 76.89, bonus: 20000 },
    ];

    res.json({
      success: true,
      packages,
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Process TapPay payment
router.post('/tappay', async (req, res) => {
  try {
    const { userId, packageId, tapPayToken } = req.body;

    // Call TapPay API
    const tapPayResponse = await axios.post(
      'https://api.tap-pay.io/v1/charges',
      {
        amount: 100, // In cents
        currency: 'AED',
        source: { id: tapPayToken },
        description: `Rizsoh Coins Package ${packageId}`,
      },
      {
        headers: {
          'Authorization': `Bearer ${process.env.TAPPAY_API_KEY}`,
        },
      }
    );

    if (tapPayResponse.data.status === 'succeeded') {
      // Add coins to user
      const packages = {
        '1': 9000,
        '2': 45500,
        '3': 91000,
        '4': 183000,
      };

      const coins = packages[packageId] || 0;

      await db.collection('users').doc(userId).update({
        coins: admin.firestore.FieldValue.increment(coins),
      });

      // Log transaction
      await db.collection('transactions').add({
        userId,
        type: 'purchase',
        status: 'completed',
        amount: coins,
        currencyType: 'coins',
        paymentMethod: 'TapPay',
        packageId,
        createdAt: new Date(),
      });

      res.json({
        success: true,
        message: `Added ${coins} coins`,
        coins,
      });
    } else {
      res.status(400).json({ error: 'Payment failed' });
    }
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Process Stripe payment
router.post('/stripe', async (req, res) => {
  try {
    const { userId, packageId, stripePaymentIntentId } = req.body;

    // Verify with Stripe
    const stripe = require('stripe')(process.env.STRIPE_API_KEY);
    const paymentIntent = await stripe.paymentIntents.retrieve(
      stripePaymentIntentId
    );

    if (paymentIntent.status === 'succeeded') {
      const packages = {
        '1': 9000,
        '2': 45500,
        '3': 91000,
        '4': 183000,
      };

      const coins = packages[packageId] || 0;

      await db.collection('users').doc(userId).update({
        coins: admin.firestore.FieldValue.increment(coins),
      });

      await db.collection('transactions').add({
        userId,
        type: 'purchase',
        status: 'completed',
        amount: coins,
        currencyType: 'coins',
        paymentMethod: 'Stripe',
        packageId,
        createdAt: new Date(),
      });

      res.json({
        success: true,
        message: `Added ${coins} coins`,
        coins,
      });
    } else {
      res.status(400).json({ error: 'Payment not completed' });
    }
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Process PayTabs payment
router.post('/paytabs', async (req, res) => {
  try {
    const { userId, packageId, paymentReference } = req.body;

    // Verify with PayTabs
    const payTabsResponse = await axios.post(
      'https://secure-api.paytabs.com/api/v1/verify_payment',
      {
        profile_id: process.env.PAYTABS_PROFILE_ID,
        reference_id: paymentReference,
      },
      {
        headers: {
          'authorization': process.env.PAYTABS_API_KEY,
        },
      }
    );

    if (payTabsResponse.data.status === 'success') {
      const packages = {
        '1': 9000,
        '2': 45500,
        '3': 91000,
        '4': 183000,
      };

      const coins = packages[packageId] || 0;

      await db.collection('users').doc(userId).update({
        coins: admin.firestore.FieldValue.increment(coins),
      });

      await db.collection('transactions').add({
        userId,
        type: 'purchase',
        status: 'completed',
        amount: coins,
        currencyType: 'coins',
        paymentMethod: 'PayTabs',
        packageId,
        createdAt: new Date(),
      });

      res.json({
        success: true,
        message: `Added ${coins} coins`,
        coins,
      });
    } else {
      res.status(400).json({ error: 'Payment verification failed' });
    }
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

module.exports = router;
