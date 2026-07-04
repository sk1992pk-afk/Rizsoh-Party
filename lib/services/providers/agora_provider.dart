import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/agora_service.dart';

final agoraServiceProvider = Provider<AgoraService>(
  (ref) => AgoraService(),
);

final remoteUsersProvider = StreamProvider<List<int>>(
  (ref) {
    final agoraService = ref.watch(agoraServiceProvider);
    return agoraService.remoteUsersNotifier.stream;
  },
);

final isMicEnabledProvider = StateNotifierProvider<
    StateNotifier<bool>,
    bool>((ref) => StateNotifier(true));

final isAudioEnabledProvider = StateNotifierProvider<
    StateNotifier<bool>,
    bool>((ref) => StateNotifier(true));
