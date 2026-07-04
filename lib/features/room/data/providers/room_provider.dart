import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/room_model.dart';
import '../repositories/room_repository.dart';

final firebaseFirestoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

final roomRepositoryProvider = Provider<RoomRepository>(
  (ref) {
    final firestore = ref.watch(firebaseFirestoreProvider);
    return RoomRepository(firestore: firestore);
  },
);

final liveRoomsProvider = StreamProvider<List<RoomModel>>(
  (ref) {
    final roomRepository = ref.watch(roomRepositoryProvider);
    return roomRepository.getLiveRooms();
  },
);

final roomByIdProvider = FutureProvider.family<RoomModel, String>(
  (ref, roomId) {
    final roomRepository = ref.watch(roomRepositoryProvider);
    return roomRepository.getRoomById(roomId);
  },
);

final roomsByCategoryProvider =
    StreamProvider.family<List<RoomModel>, String>(
  (ref, category) {
    final roomRepository = ref.watch(roomRepositoryProvider);
    return roomRepository.getRoomsByCategory(category);
  },
);
