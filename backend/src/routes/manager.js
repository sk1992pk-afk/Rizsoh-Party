const express = require('express');
const admin = require('firebase-admin');
const router = express.Router();

const db = admin.firestore();

// Create agency
router.post('/create-agency', async (req, res) => {
  try {
    const { bdId, name } = req.body;

    const agencyRef = await db.collection('agencies').add({
      bdId,
      name,
      revenue: 0,
      memberIds: [],
      level: 'bronze',
      totalCoinsGenerated: 0,
      createdAt: new Date(),
      updatedAt: new Date(),
    });

    // Update BD's agencyId
    await db.collection('users').doc(bdId).update({
      agencyId: agencyRef.id,
      role: 'bd',
    });

    res.json({
      success: true,
      agencyId: agencyRef.id,
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Hire team member
router.post('/hire-member', async (req, res) => {
  try {
    const { agencyId, memberId, position } = req.body;

    // Add to agency
    await db.collection('agencies').doc(agencyId).update({
      memberIds: admin.firestore.FieldValue.arrayUnion([memberId]),
    });

    // Update member
    await db.collection('users').doc(memberId).update({
      agencyId,
      role: 'bd',
    });

    res.json({
      success: true,
      message: 'Member hired successfully',
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get user agency
router.get('/:userId/agency', async (req, res) => {
  try {
    const { userId } = req.params;

    const userDoc = await db.collection('users').doc(userId).get();
    const agencyId = userDoc.data()?.agencyId;

    if (!agencyId) {
      return res.status(404).json({ error: 'No agency found' });
    }

    const agencyDoc = await db.collection('agencies').doc(agencyId).get();

    res.json({
      success: true,
      agency: agencyDoc.data(),
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Calculate and get monthly salary
router.get('/:userId/salary/:month', async (req, res) => {
  try {
    const { userId, month } = req.params;

    // Check if salary already calculated
    const existing = await db
      .collection('salaries')
      .where('userId', '==', userId)
      .where('month', '==', month)
      .limit(1)
      .get();

    if (!existing.empty) {
      return res.json({
        success: true,
        salary: existing.docs[0].data(),
      });
    }

    // Calculate new salary
    const userDoc = await db.collection('users').doc(userId).get();
    const agencyId = userDoc.data()?.agencyId;

    let salary1 = 0;
    let salary2 = 0;
    let salary3 = 0;

    if (agencyId) {
      const agencyDoc = await db.collection('agencies').doc(agencyId).get();
      const totalCoins = agencyDoc.data()?.totalCoinsGenerated || 0;

      // Tier based salary
      if (totalCoins >= 500000) salary1 = 50;
      else if (totalCoins >= 250000) salary1 = 30;
      else if (totalCoins >= 100000) salary1 = 15;
      else salary1 = 5;

      // Revenue commission (10%)
      salary2 = totalCoins * 0.1;
    }

    const totalSalary = 100 + salary1 + salary2 + salary3;

    const salaryRef = await db.collection('salaries').add({
      userId,
      month,
      baseSalary: 100,
      salary1AgencyOpening: salary1,
      salary2RevenueCommission: salary2,
      salary3Bonus: salary3,
      totalSalary,
      withdrawn: false,
      createdAt: new Date(),
    });

    res.json({
      success: true,
      salary: {
        id: salaryRef.id,
        userId,
        month,
        baseSalary: 100,
        salary1: salary1,
        salary2: salary2,
        salary3: salary3,
        totalSalary,
        withdrawn: false,
      },
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Withdraw salary
router.post('/:userId/withdraw', async (req, res) => {
  try {
    const { userId } = req.params;
    const { salaryId } = req.body;

    // Update salary as withdrawn
    await db.collection('salaries').doc(salaryId).update({
      withdrawn: true,
      withdrawnAt: new Date(),
    });

    res.json({
      success: true,
      message: 'Salary withdrawn successfully',
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Update user role
router.post('/update-role', async (req, res) => {
  try {
    const { userId, role } = req.body;

    await db.collection('users').doc(userId).update({
      role,
    });

    res.json({
      success: true,
      message: 'User role updated',
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

module.exports = router;
