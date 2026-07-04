import 'package:freezed_annotation/freezed_annotation.dart';

part 'agency_model.freezed.dart';
part 'agency_model.g.dart';

enum AgencyLevel { bronze, silver, gold, platinum }

@freezed
class AgencyModel with _$AgencyModel {
  const factory AgencyModel({
    required String agencyId,
    required String bdId,
    required String name,
    @Default(0) int revenue,
    @Default([]) List<String> memberIds,
    @Default(AgencyLevel.bronze) AgencyLevel level,
    @Default(0) int totalCoinsGenerated,
    @Default(0) int targetCoins,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AgencyModel;

  factory AgencyModel.fromJson(Map<String, dynamic> json) =>
      _$AgencyModelFromJson(json);
}
