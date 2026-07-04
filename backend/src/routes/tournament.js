const express = require('express');
const admin = require('firebase-admin');
const router = express.Router();

const db = admin.firestore();

// Create tournament
router.post('/create', async (req, res) => {
  try {
    const { title, game, entryFee, maxParticipants, prizePool } = req.body;

    const tournamentRef = await db.collection('tournaments').add({
      title,
      game,
      entryFee,
      maxParticipants,
      prizePool,
      status: 'pending',
      participants: [],
      createdAt: new Date(),
    });

    res.json({
      success: true,
      tournamentId: tournamentRef.id,
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get tournament
router.get('/:tournamentId', async (req, res) => {
  try {
    const { tournamentId } = req.params;

    const tournamentDoc = await db
      .collection('tournaments')
      .doc(tournamentId)
      .get();

    if (!tournamentDoc.exists) {
      return res.status(404).json({ error: 'Tournament not found' });
    }

    res.json({
      success: true,
      tournament: {
        id: tournamentDoc.id,
        ...tournamentDoc.data(),
      },
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Join tournament
router.post('/:tournamentId/join', async (req, res) => {
  try {
    const { tournamentId } = req.params;
    const { userId } = req.body;

    const tournamentDoc = await db
      .collection('tournaments')
      .doc(tournamentId)
      .get();
    const tournament = tournamentDoc.data();

    if (tournament.participants.length >= tournament.maxParticipants) {
      return res.status(400).json({ error: 'Tournament is full' });
    }

    // Deduct entry fee from user
    const userDoc = await db.collection('users').doc(userId).get();
    const userCoins = userDoc.data()?.coins || 0;

    if (userCoins < tournament.entryFee) {
      return res.status(400).json({ error: 'Insufficient coins' });
    }

    // Deduct coins
    await db.collection('users').doc(userId).update({
      coins: admin.firestore.FieldValue.increment(-tournament.entryFee),
    });

    // Add to tournament
    await db.collection('tournaments').doc(tournamentId).update({
      participants: admin.firestore.FieldValue.arrayUnion([userId]),
    });

    res.json({
      success: true,
      message: 'Joined tournament',
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Start tournament
router.post('/:tournamentId/start', async (req, res) => {
  try {
    const { tournamentId } = req.params;

    await db.collection('tournaments').doc(tournamentId).update({
      status: 'live',
      startedAt: new Date(),
    });

    res.json({
      success: true,
      message: 'Tournament started',
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// End tournament
router.post('/:tournamentId/end', async (req, res) => {
  try {
    const { tournamentId } = req.params;
    const { winners } = req.body; // Array of {userId, placement}

    await db.collection('tournaments').doc(tournamentId).update({
      status: 'ended',
      winners,
      endedAt: new Date(),
    });

    // Distribute prizes
    const tournamentDoc = await db
      .collection('tournaments')
      .doc(tournamentId)
      .get();
    const prizePool = tournamentDoc.data()?.prizePool || 0;
    const prizePerWinner = prizePool / winners.length;

    for (const winner of winners) {
      await db.collection('users').doc(winner.userId).update({
        coins: admin.firestore.FieldValue.increment(Math.floor(prizePerWinner)),
      });
    }

    res.json({
      success: true,
      message: 'Tournament ended and prizes distributed',
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

module.module.exports = router;
