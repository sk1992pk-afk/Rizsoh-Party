import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_model.freezed.dart';
part 'room_model.g.dart';

@freezed
class RoomModel with _$RoomModel {
  const factory RoomModel({
    required String roomId,
    required String title,
    required String hostName,
    required int viewerCount,
    required String coverUrl,
    required String category,
    @Default(0) int maxParticipants,
    @Default([]) List<String> activeMics,
  }) = _RoomModel;

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);
}
