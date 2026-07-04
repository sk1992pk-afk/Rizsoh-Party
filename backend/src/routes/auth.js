const express = require('express');
const admin = require('firebase-admin');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const router = express.Router();

const db = admin.firestore();
const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key';

// Register
router.post('/register', async (req, res) => {
  try {
    const { email, password, name } = req.body;

    // Create auth user
    const userRecord = await admin.auth().createUser({
      email,
      password,
      displayName: name,
    });

    // Create firestore doc
    await db.collection('users').doc(userRecord.uid).set({
      uid: userRecord.uid,
      email,
      name,
      role: 'user',
      coins: 0,
      diamonds: 0,
      level: 1,
      createdAt: new Date(),
      updatedAt: new Date(),
    });

    // Generate JWT
    const token = jwt.sign({ uid: userRecord.uid, email }, JWT_SECRET, {
      expiresIn: '24h',
    });

    res.json({
      success: true,
      user: {
        uid: userRecord.uid,
        email,
        name,
      },
      token,
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Login
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    // Verify with Firebase Auth
    const user = await admin.auth().getUserByEmail(email);

    // In production, use Firebase REST API or custom token
    const userDoc = await db.collection('users').doc(user.uid).get();

    const token = jwt.sign({ uid: user.uid, email }, JWT_SECRET, {
      expiresIn: '24h',
    });

    res.json({
      success: true,
      user: userDoc.data(),
      token,
    });
  } catch (error) {
    res.status(401).json({ error: 'Invalid credentials' });
  }
});

// Refresh token
router.post('/refresh-token', (req, res) => {
  try {
    const { token } = req.body;

    const decoded = jwt.verify(token, JWT_SECRET, { ignoreExpiration: true });

    const newToken = jwt.sign(
      { uid: decoded.uid, email: decoded.email },
      JWT_SECRET,
      { expiresIn: '24h' }
    );

    res.json({ token: newToken });
  } catch (error) {
    res.status(401).json({ error: 'Invalid token' });
  }
});

module.exports = router;
