import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/payment_package_model.dart';

class PaymentRepository {
  final FirebaseFirestore _firestore;

  PaymentRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  // Get all payment packages
  Future<List<PaymentPackageModel>> getPaymentPackages() async {
    try {
      final snapshot = await _firestore.collection('payment_packages').get();
      return snapshot.docs
          .map((doc) => PaymentPackageModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  // Process payment via TapPay
  Future<bool> processPaymentTapPay({
    required String userId,
    required String packageId,
    required String tapPayToken,
  }) async {
    try {
      // Call TapPay API (implement actual API call)
      // For now, mock implementation
      await Future.delayed(const Duration(seconds: 2));

      // Get package details
      final packageDoc =
          await _firestore.collection('payment_packages').doc(packageId).get();
      final coins = packageDoc.get('coins') as int;

      // Add coins to user
      await _firestore.collection('users').doc(userId).update({
        'coins': FieldValue.increment(coins),
      });

      // Log transaction
      await _firestore.collection('transactions').add({
        'userId': userId,
        'type': 'purchase',
        'status': 'completed',
        'amount': coins,
        'currencyType': 'coins',
        'paymentMethod': 'TapPay',
        'packageId': packageId,
        'createdAt': DateTime.now(),
      });

      return true;
    } catch (e) {
      rethrow;
    }
  }

  // Process payment via Stripe
  Future<bool> processPaymentStripe({
    required String userId,
    required String packageId,
    required String stripePaymentIntentId,
  }) async {
    try {
      // Call Stripe API (implement actual API call)
      await Future.delayed(const Duration(seconds: 2));

      // Get package details
      final packageDoc =
          await _firestore.collection('payment_packages').doc(packageId).get();
      final coins = packageDoc.get('coins') as int;

      // Add coins to user
      await _firestore.collection('users').doc(userId).update({
        'coins': FieldValue.increment(coins),
      });

      // Log transaction
      await _firestore.collection('transactions').add({
        'userId': userId,
        'type': 'purchase',
        'status': 'completed',
        'amount': coins,
        'currencyType': 'coins',
        'paymentMethod': 'Stripe',
        'packageId': packageId,
        'createdAt': DateTime.now(),
      });

      return true;
    } catch (e) {
      rethrow;
    }
  }
}
