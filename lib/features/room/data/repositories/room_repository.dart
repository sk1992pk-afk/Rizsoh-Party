import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/room_model.dart';

class RoomRepository {
  final FirebaseFirestore _firestore;

  RoomRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  // Create new room
  Future<RoomModel> createRoom({
    required String hostId,
    required String hostName,
    required String title,
    required String category,
    required String coverUrl,
  }) async {
    try {
      final roomId = _firestore.collection('rooms').doc().id;
      final agoraRoomId = roomId; // Use same ID for Agora channel

      final room = RoomModel(
        roomId: roomId,
        title: title,
        hostId: hostId,
        hostName: hostName,
        category: RoomCategory.values.byName(category),
        coverUrl: coverUrl,
        agoraRoomId: agoraRoomId,
        createdAt: DateTime.now(),
      );

      await _firestore.collection('rooms').doc(roomId).set(room.toJson());
      return room;
    } catch (e) {
      rethrow;
    }
  }

  // Get all live rooms
  Stream<List<RoomModel>> getLiveRooms() {
    return _firestore
        .collection('rooms')
        .where('status', isEqualTo: 'live')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => RoomModel.fromJson(doc.data()))
          .toList();
    });
  }

  // Get room by ID
  Future<RoomModel> getRoomById(String roomId) async {
    try {
      final doc = await _firestore.collection('rooms').doc(roomId).get();
      return RoomModel.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  // Join room
  Future<void> joinRoom({
    required String roomId,
    required String userId,
  }) async {
    try {
      await _firestore.collection('rooms').doc(roomId).update({
        'participantIds': FieldValue.arrayUnion([userId]),
        'viewerCount': FieldValue.increment(1),
      });
    } catch (e) {
      rethrow;
    }
  }

  // Leave room
  Future<void> leaveRoom({
    required String roomId,
    required String userId,
  }) async {
    try {
      await _firestore.collection('rooms').doc(roomId).update({
        'participantIds': FieldValue.arrayRemove([userId]),
        'viewerCount': FieldValue.increment(-1),
        'activeMics': FieldValue.arrayRemove([userId]),
      });
    } catch (e) {
      rethrow;
    }
  }

  // Update active mics
  Future<void> updateActiveMics({
    required String roomId,
    required List<String> mics,
  }) async {
    try {
      await _firestore.collection('rooms').doc(roomId).update({
        'activeMics': mics,
        'activeParticipants': mics.length,
      });
    } catch (e) {
      rethrow;
    }
  }

  // End room
  Future<void> endRoom(String roomId) async {
    try {
      await _firestore.collection('rooms').doc(roomId).update({
        'status': 'ended',
        'endedAt': DateTime.now(),
      });
    } catch (e) {
      rethrow;
    }
  }

  // Get rooms by category
  Stream<List<RoomModel>> getRoomsByCategory(String category) {
    return _firestore
        .collection('rooms')
        .where('category', isEqualTo: category)
        .where('status', isEqualTo: 'live')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => RoomModel.fromJson(doc.data()))
          .toList();
    });
  }
}
