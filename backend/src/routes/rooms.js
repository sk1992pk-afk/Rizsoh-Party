const express = require('express');
const admin = require('firebase-admin');
const router = express.Router();

const db = admin.firestore();

// Create room
router.post('/create', async (req, res) => {
  try {
    const { hostId, hostName, title, category, coverUrl } = req.body;

    const roomRef = await db.collection('rooms').add({
      hostId,
      hostName,
      title,
      category,
      coverUrl,
      status: 'waiting',
      viewerCount: 1,
      activeParticipants: 1,
      activeMics: [hostId],
      participantIds: [hostId],
      totalCoinsSpent: 0,
      createdAt: new Date(),
    });

    res.json({
      success: true,
      roomId: roomRef.id,
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get live rooms
router.get('/live', async (req, res) => {
  try {
    const snapshot = await db
      .collection('rooms')
      .where('status', '==', 'live')
      .limit(50)
      .get();

    const rooms = [];
    snapshot.forEach((doc) => {
      rooms.push({
        roomId: doc.id,
        ...doc.data(),
      });
    });

    res.json({
      success: true,
      rooms,
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get room by ID
router.get('/:roomId', async (req, res) => {
  try {
    const { roomId } = req.params;

    const roomDoc = await db.collection('rooms').doc(roomId).get();

    if (!roomDoc.exists) {
      return res.status(404).json({ error: 'Room not found' });
    }

    res.json({
      success: true,
      room: {
        roomId: roomDoc.id,
        ...roomDoc.data(),
      },
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Join room
router.post('/:roomId/join', async (req, res) => {
  try {
    const { roomId } = req.params;
    const { userId } = req.body;

    await db.collection('rooms').doc(roomId).update({
      participantIds: admin.firestore.FieldValue.arrayUnion([userId]),
      viewerCount: admin.firestore.FieldValue.increment(1),
    });

    res.json({
      success: true,
      message: 'Joined room',
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Leave room
router.post('/:roomId/leave', async (req, res) => {
  try {
    const { roomId } = req.params;
    const { userId } = req.body;

    await db.collection('rooms').doc(roomId).update({
      participantIds: admin.firestore.FieldValue.arrayRemove([userId]),
      activeMics: admin.firestore.FieldValue.arrayRemove([userId]),
      viewerCount: admin.firestore.FieldValue.increment(-1),
    });

    res.json({
      success: true,
      message: 'Left room',
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Generate Agora token
router.post('/:roomId/generate-token', async (req, res) => {
  try {
    const { roomId } = req.params;
    const { userId } = req.body;

    const AgoraToken = require('agora-token-builder');
    const agoraAppId = process.env.AGORA_APP_ID;
    const agoraAppCertificate = process.env.AGORA_APP_CERTIFICATE;

    // Generate token
    const token = AgoraToken.RtcTokenBuilder.buildTokenWithUid(
      agoraAppId,
      agoraAppCertificate,
      roomId,
      parseInt(userId),
      AgoraToken.RtcRole.PUBLISHER,
      3600 // 1 hour
    );

    res.json({
      success: true,
      token,
      agoraAppId,
      channelName: roomId,
      uid: userId,
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

module.exports = router;
