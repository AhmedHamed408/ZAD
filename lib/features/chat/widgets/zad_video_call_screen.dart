import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/mock/mock_users.dart';
import '../../../localization/app_localizations.dart';
import '../../../providers/transaction_provider.dart';

class ZadVideoCallScreen extends StatefulWidget {
  final String userId;
  final String userName;
  final String userAvatar;

  const ZadVideoCallScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.userAvatar,
  });

  @override
  State<ZadVideoCallScreen> createState() => _ZadVideoCallScreenState();
}

class _ZadVideoCallScreenState extends State<ZadVideoCallScreen> {
  bool _isConnected = false;
  int _durationSeconds = 0;
  bool _isMuted = false;
  bool _isCameraOn = true;
  bool _isFrontCamera = true;
  bool _isSpeakerOn = true;

  Timer? _connectTimer;
  Timer? _durationTimer;

  @override
  void initState() {
    super.initState();

    _connectTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isConnected = true;
        });
        _startTimer();
      }
    });
  }

  void _startTimer() {
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _durationSeconds++;
        });
      }
    });
  }

  void _endCall() {
    _connectTimer?.cancel();
    _durationTimer?.cancel();

    final status = _isConnected ? 'completed' : 'cancelled';
    final txProvider = Provider.of<TransactionProvider>(context, listen: false);

    txProvider.addCallLogMessage(
      otherUserId: widget.userId,
      callType: 'video',
      callStatus: status,
      durationSeconds: _durationSeconds,
    );

    if (mounted) {
      Navigator.pop(context);
    }
  }

  String _formatTimer(int totalSecs) {
    final mins = (totalSecs ~/ 60).toString().padLeft(2, '0');
    final secs = (totalSecs % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  @override
  void dispose() {
    _connectTimer?.cancel();
    _durationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserAvatar = MockUsers.currentUser.profileImage;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Simulated Remote Video Feed (Background)
          Positioned.fill(
            child: Container(
              color: const Color(0xFF0F172A),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.userAvatar,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(color: Colors.black54),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.7),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.85),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Top Header Overlay
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _endCall,
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                ),
                Column(
                  children: [
                    Text(
                      widget.userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: (_isConnected ? AppColors.success : AppColors.accent)
                            .withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _isConnected
                            ? '${'connected'.tr(context)} • ${_formatTimer(_durationSeconds)}'
                            : 'calling'.tr(context),
                        style: TextStyle(
                          color: _isConnected ? AppColors.success : AppColors.accent,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade700.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.amberAccent),
                  ),
                  child: Text(
                    'demo_call'.tr(context),
                    style: const TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // PiP (Picture-in-Picture) Local Preview Window
          Positioned(
            top: 120,
            right: 20,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 110,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white38, width: 1.5),
                boxShadow: const [
                  BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 4)),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: _isCameraOn
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            currentUserAvatar,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 4,
                            left: 4,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                _isFrontCamera ? 'Front' : 'Back',
                                style: const TextStyle(color: Colors.white, fontSize: 9),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.videocam_off_rounded, color: Colors.white54, size: 24),
                            const SizedBox(height: 4),
                            Text(
                              'camera_off'.tr(context),
                              style: const TextStyle(color: Colors.white54, fontSize: 9),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),

          // Bottom Controls Overlay Panel
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.65),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Mute
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isMuted = !_isMuted;
                      });
                    },
                    icon: Icon(_isMuted ? Icons.mic_off_rounded : Icons.mic_rounded),
                    color: _isMuted ? Colors.red : Colors.white,
                  ),

                  // Camera Toggle
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isCameraOn = !_isCameraOn;
                      });
                    },
                    icon: Icon(_isCameraOn ? Icons.videocam_rounded : Icons.videocam_off_rounded),
                    color: _isCameraOn ? Colors.white : Colors.red,
                  ),

                  // End Call (Red)
                  IconButton.filled(
                    onPressed: _endCall,
                    icon: const Icon(Icons.call_end_rounded, size: 28),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(14),
                    ),
                  ),

                  // Switch Camera
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isFrontCamera = !_isFrontCamera;
                      });
                    },
                    icon: const Icon(Icons.cameraswitch_rounded),
                    color: Colors.white,
                  ),

                  // Speaker
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isSpeakerOn = !_isSpeakerOn;
                      });
                    },
                    icon: Icon(_isSpeakerOn ? Icons.volume_up_rounded : Icons.volume_down_rounded),
                    color: _isSpeakerOn ? AppColors.accent : Colors.white54,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
