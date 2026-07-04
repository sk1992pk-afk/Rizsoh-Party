import 'package:freezed_annotation/freezed_annotation.dart';

part 'gift_model.freezed.dart';
part 'gift_model.g.dart';

enum GiftCategory { diamond, starlight, pet, vehicle, decoration }

@freezed
class GiftModel with _$GiftModel {
  const factory GiftModel({
    required String giftId,
    required String name,
    required int coinPrice,
    required int diamondPrice,
    required String imageUrl,
    @Default(GiftCategory.decoration) GiftCategory category,
    String? description,
    @Default(0) int purchaseCount,
  }) = _GiftModel;

  factory GiftModel.fromJson(Map<String, dynamic> json) =>
      _$GiftModelFromJson(json);
}
