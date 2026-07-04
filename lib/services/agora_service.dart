import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class AgoraService {
  static const String agoraAppId = 'YOUR_AGORA_APP_ID'; // Replace with actual ID
  
  late RtcEngine _engine;
  bool _isInitialized = false;
  
  int? _localUid;
  final List<int> _remoteUids = [];
  
  // Callbacks
  final ValueNotifier<List<int>> remoteUsersNotifier = ValueNotifier([]);
  final ValueNotifier<bool> isMicEnabledNotifier = ValueNotifier(true);
  final ValueNotifier<bool> isAudioEnabledNotifier = ValueNotifier(true);

  Future<void> initialize() async {
    if (_isInitialized) return;

    _engine = createAgoraRtcEngine();
    await _engine.initialize(
      RtcEngineContext(
        appId: agoraAppId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );

    // Register event handlers
    _setupEventHandlers();
    _isInitialized = true;
  }

  void _setupEventHandlers() {
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint('Local user uid:${connection.localUid} joined the channel');
          _localUid = connection.localUid;
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint('Remote user $remoteUid joined');
          _remoteUids.add(remoteUid);
          remoteUsersNotifier.value = List.from(_remoteUids);
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint('Remote user $remoteUid left channel');
          _remoteUids.remove(remoteUid);
          remoteUsersNotifier.value = List.from(_remoteUids);
        },
        onError: (ErrorCodeType err, String msg) {
          debugPrint('[onError] err: $err, msg: $msg');
        },
      ),
    );
  }

  Future<void> joinChannel({
    required String channelName,
    required String token,
    required int uid,
  }) async {
    // Request permissions
    await _requestPermissions();

    await _engine.enableAudio();
    await _engine.setAudioProfile(
      profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioGameStreaming,
    );

    await _engine.joinChannel(
      token: token,
      channelId: channelName,
      uid: uid,
      options: const RtcChannelMediaOptions(
        autoSubscribeAudio: true,
        autoSubscribeVideo: false,
      ),
    );
  }

  Future<void> leaveChannel() async {
    await _engine.leaveChannel();
    _remoteUids.clear();
    remoteUsersNotifier.value = [];
  }

  Future<void> toggleMic(bool enable) async {
    await _engine.enableLocalAudio(enable);
    isMicEnabledNotifier.value = enable;
  }

  Future<void> toggleAudio(bool enable) async {
    await _engine.muteAllRemoteAudioStreams(!enable);
    isAudioEnabledNotifier.value = enable;
  }

  Future<void> _requestPermissions() async {
    await Permission.microphone.request();
  }

  void dispose() {
    _engine.release();
    _isInitialized = false;
    _remoteUids.clear();
  }

  List<int> get remoteUids => _remoteUids;
  int? get localUid => _localUid;
  bool get isInitialized => _isInitialized;
}
