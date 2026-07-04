import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../services/agora_service.dart';
import '../../../services/providers/agora_provider.dart';

class RoomPage extends ConsumerStatefulWidget {
  final String roomId;

  const RoomPage({Key? key, required this.roomId}) : super(key: key);

  @override
  ConsumerState<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends ConsumerState<RoomPage> {
  late AgoraService _agoraService;
  bool _isMicEnabled = true;
  bool _isAudioEnabled = true;

  @override
  void initState() {
    super.initState();
    _agoraService = ref.read(agoraServiceProvider);
    _initializeAgora();
  }

  Future<void> _initializeAgora() async {
    await _agoraService.initialize();
    // Join channel - in real app, get token from backend
    await _agoraService.joinChannel(
      channelName: widget.roomId,
      token: 'AGORA_TOKEN', // Get from backend
      uid: 0, // Will be assigned by Agora
    );
  }

  @override
  void dispose() {
    _agoraService.leaveChannel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remoteUsers = ref.watch(remoteUsersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Room'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Active participants count
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Active Participants: ${remoteUsers.maybeWhen(
                data: (users) => users.length + 1,
                orElse: () => 1,
              )}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          // Remote users list
          Expanded(
            child: remoteUsers.when(
              data: (users) {
                if (users.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.mic,
                          size: 64,
                          color: Color(0xFF00D9FF),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'You\'re the only one here',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Waiting for others to join...',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return _buildParticipantTile(users[index]);
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (err, stack) => Center(
                child: Text('Error: $err'),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          border: Border(
            top: BorderSide(
              color: const Color(0xFF7B2CBF),
              width: 1.5,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Mic Toggle
            FloatingActionButton(
              onPressed: () async {
                setState(() {
                  _isMicEnabled = !_isMicEnabled;
                });
                await _agoraService.toggleMic(_isMicEnabled);
              },
              backgroundColor: _isMicEnabled
                  ? const Color(0xFF7B2CBF)
                  : const Color(0xFFFF006E),
              child: Icon(
                _isMicEnabled ? Icons.mic : Icons.mic_off,
                color: Colors.white,
              ),
            ),
            // Audio Toggle
            FloatingActionButton(
              onPressed: () async {
                setState(() {
                  _isAudioEnabled = !_isAudioEnabled;
                });
                await _agoraService.toggleAudio(_isAudioEnabled);
              },
              backgroundColor: _isAudioEnabled
                  ? const Color(0xFF7B2CBF)
                  : const Color(0xFFFF006E),
              child: Icon(
                _isAudioEnabled ? Icons.volume_up : Icons.volume_off,
                color: Colors.white,
              ),
            ),
            // Leave Room
            FloatingActionButton(
              onPressed: () {
                context.pop();
              },
              backgroundColor: const Color(0xFFFF006E),
              child: const Icon(Icons.call_end, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParticipantTile(int uid) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F1E),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF7B2CBF),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF7B2CBF),
            child: Icon(
              Icons.person,
              color: const Color(0xFFFFD700),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User #$uid',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Speaking...',
                style: TextStyle(
                  color: Color(0xFF00D9FF),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.mic,
            color: Color(0xFF00D9FF),
          ),
        ],
      ),
    );
  }
}
