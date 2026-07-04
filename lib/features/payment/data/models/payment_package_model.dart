import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_package_model.freezed.dart';
part 'payment_package_model.g.dart';

@freezed
class PaymentPackageModel with _$PaymentPackageModel {
  const factory PaymentPackageModel({
    required String packageId,
    required int coins,
    required double priceAED,
    required String description,
    @Default(0) double bonusCoinsPercentage,
    @Default(false) bool isPopular,
  }) = _PaymentPackageModel;

  factory PaymentPackageModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentPackageModelFromJson(json);
}
