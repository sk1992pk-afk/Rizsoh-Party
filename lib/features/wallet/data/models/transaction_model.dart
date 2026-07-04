import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

enum TransactionType { purchase, gift, exchange, reward, withdrawal }
enum TransactionStatus { pending, completed, failed }

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String transactionId,
    required String userId,
    @Default(TransactionType.purchase) TransactionType type,
    @Default(TransactionStatus.pending) TransactionStatus status,
    required int amount,
    String? currencyType, // coins or diamonds
    String? description,
    String? relatedItemId,
    String? paymentMethod,
    DateTime? createdAt,
    DateTime? completedAt,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}
