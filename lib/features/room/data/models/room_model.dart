import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_model.freezed.dart';
part 'room_model.g.dart';

enum RoomCategory { casual, competitive, tournament, music, gaming }
enum RoomStatus { waiting, live, ended }

@freezed
class RoomModel with _$RoomModel {
  const factory RoomModel({
    required String roomId,
    required String title,
    required String hostId,
    required String hostName,
    @Default(RoomCategory.casual) RoomCategory category,
    @Default(RoomStatus.waiting) RoomStatus status,
    @Default(0) int viewerCount,
    @Default(0) int activeParticipants,
    @Default(8) int maxParticipants,
    @Default([]) List<String> activeMics,
    required String coverUrl,
    String? agoraRoomId,
    String? agoraToken,
    @Default(0) int totalCoinsSpent,
    @Default([]) List<String> participantIds,
    DateTime? createdAt,
    DateTime? endedAt,
  }) = _RoomModel;

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);
}
