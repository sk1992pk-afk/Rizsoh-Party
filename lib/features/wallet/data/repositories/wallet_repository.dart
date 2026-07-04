import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/transaction_model.dart';
import '../models/gift_model.dart';

class WalletRepository {
  final FirebaseFirestore _firestore;

  WalletRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  // Get user coins
  Future<int> getUserCoins(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      return doc.get('coins') as int? ?? 0;
    } catch (e) {
      rethrow;
    }
  }

  // Get user diamonds
  Future<int> getUserDiamonds(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      return doc.get('diamonds') as int? ?? 0;
    } catch (e) {
      rethrow;
    }
  }

  // Add coins
  Future<void> addCoins(String userId, int amount) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'coins': FieldValue.increment(amount),
      });
    } catch (e) {
      rethrow;
    }
  }

  // Deduct coins
  Future<void> deductCoins(String userId, int amount) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'coins': FieldValue.increment(-amount),
      });
    } catch (e) {
      rethrow;
    }
  }

  // Add diamonds
  Future<void> addDiamonds(String userId, int amount) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'diamonds': FieldValue.increment(amount),
      });
    } catch (e) {
      rethrow;
    }
  }

  // Exchange diamonds for coins
  Future<bool> exchangeDiamondsForCoins({
    required String userId,
    required int diamonds,
  }) async {
    try {
      final currentDiamonds = await getUserDiamonds(userId);
      if (currentDiamonds < diamonds) return false;

      final coins = (diamonds * 0.04).toInt(); // 100 diamonds = 4 coins

      await _firestore.collection('users').doc(userId).update({
        'diamonds': FieldValue.increment(-diamonds),
        'coins': FieldValue.increment(coins),
      });

      // Log transaction
      await _logTransaction(
        userId: userId,
        type: TransactionType.exchange,
        amount: diamonds,
        currencyType: 'diamonds',
        description: 'Exchange $diamonds diamonds for $coins coins',
      );

      return true;
    } catch (e) {
      rethrow;
    }
  }

  // Send gift
  Future<bool> sendGift({
    required String senderId,
    required String receiverId,
    required String giftId,
    required int cost,
  }) async {
    try {
      final senderCoins = await getUserCoins(senderId);
      if (senderCoins < cost) return false;

      // Deduct from sender
      await deductCoins(senderId, cost);

      // Add to receiver
      await addCoins(receiverId, (cost * 0.7).toInt()); // Receiver gets 70%

      // Log transaction
      await _logTransaction(
        userId: senderId,
        type: TransactionType.gift,
        amount: cost,
        currencyType: 'coins',
        relatedItemId: giftId,
        description: 'Sent gift to $receiverId',
      );

      return true;
    } catch (e) {
      rethrow;
    }
  }

  // Get user transactions
  Stream<List<TransactionModel>> getUserTransactions(String userId) {
    return _firestore
        .collection('transactions')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => TransactionModel.fromJson(doc.data()))
          .toList();
    });
  }

  // Get all gifts
  Future<List<GiftModel>> getAllGifts() async {
    try {
      final snapshot = await _firestore.collection('gifts').get();
      return snapshot.docs
          .map((doc) => GiftModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  // Private method to log transaction
  Future<void> _logTransaction({
    required String userId,
    required TransactionType type,
    required int amount,
    String? currencyType,
    String? relatedItemId,
    String? description,
  }) async {
    try {
      await _firestore.collection('transactions').add({
        'userId': userId,
        'type': type.name,
        'status': TransactionStatus.completed.name,
        'amount': amount,
        'currencyType': currencyType,
        'relatedItemId': relatedItemId,
        'description': description,
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      rethrow;
    }
  }
}
