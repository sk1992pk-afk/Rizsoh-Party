import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/transaction_model.dart';
import '../models/gift_model.dart';
import '../repositories/wallet_repository.dart';

final firebaseFirestoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

final walletRepositoryProvider = Provider<WalletRepository>(
  (ref) {
    final firestore = ref.watch(firebaseFirestoreProvider);
    return WalletRepository(firestore: firestore);
  },
);

final userCoinsProvider = FutureProvider.family<int, String>(
  (ref, userId) {
    final walletRepository = ref.watch(walletRepositoryProvider);
    return walletRepository.getUserCoins(userId);
  },
);

final userDiamondsProvider = FutureProvider.family<int, String>(
  (ref, userId) {
    final walletRepository = ref.watch(walletRepositoryProvider);
    return walletRepository.getUserDiamonds(userId);
  },
);

final userTransactionsProvider =
    StreamProvider.family<List<TransactionModel>, String>(
  (ref, userId) {
    final walletRepository = ref.watch(walletRepositoryProvider);
    return walletRepository.getUserTransactions(userId);
  },
);

final allGiftsProvider = FutureProvider<List<GiftModel>>(
  (ref) {
    final walletRepository = ref.watch(walletRepositoryProvider);
    return walletRepository.getAllGifts();
  },
);
