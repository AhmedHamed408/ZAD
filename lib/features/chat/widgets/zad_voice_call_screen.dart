import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../localization/app_localizations.dart';
import '../../../providers/transaction_provider.dart';

class ZadVoiceCallScreen extends StatefulWidget {
  final String userId;
  final String userName;
  final String userAvatar;

  const ZadVoiceCallScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.userAvatar,
  });

  @override
  State<ZadVoiceCallScreen> createState() => _ZadVoiceCallScreenState();
}

class _ZadVoiceCallScreenState extends State<ZadVoiceCallScreen>
    with SingleTickerProviderStateMixin {
  bool _isConnected = false;
  int _durationSeconds = 0;
  bool _isMuted = false;
  bool _isSpeakerOn = true;

  Timer? _connectTimer;
  Timer? _durationTimer;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.22).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Simulate 2-second connection delay
    _connectTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isConnected = true;
        });
        _pulseController.stop();
        _startCallTimer();
      }
    });
  }

  void _startCallTimer() {
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
      callType: 'voice',
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
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Top Header: Demo Call Badge
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _endCall,
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade700.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.amberAccent, width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.flash_on_rounded, size: 14, color: Colors.amberAccent),
                        const SizedBox(width: 4),
                        Text(
                          'demo_call'.tr(context),
                          style: const TextStyle(
                            color: Colors.amberAccent,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 48), // Balancing space for back button
                ],
              ),
            ),

            const Spacer(),

            // Avatar & Ring Pulse
            ScaleTransition(
              scale: _isConnected
                  ? const AlwaysStoppedAnimation(1.0)
                  : _pulseAnimation,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accent.withValues(alpha: _isConnected ? 0.15 : 0.3),
                  border: Border.all(
                    color: _isConnected ? AppColors.success : AppColors.accent,
                    width: 3,
                  ),
                ),
                child: CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(widget.userAvatar),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Contact Name
            Text(
              widget.userName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Connection Status / Timer
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: (_isConnected ? AppColors.success : AppColors.accent)
                    .withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _isConnected
                    ? _formatTimer(_durationSeconds)
                    : 'calling'.tr(context),
                style: TextStyle(
                  color: _isConnected ? AppColors.success : AppColors.accent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Spacer(),

            // Control Buttons
            Padding(
              padding: const EdgeInsets.only(bottom: 40, left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Mute Button
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton.filled(
                        onPressed: () {
                          setState(() {
                            _isMuted = !_isMuted;
                          });
                        },
                        icon: Icon(
                          _isMuted
                              ? Icons.mic_off_rounded
                              : Icons.mic_rounded,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: _isMuted ? Colors.red : Colors.white24,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isMuted ? 'muted'.tr(context) : 'microphone'.tr(context),
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),

                  // End Call Button
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton.filled(
                        onPressed: _endCall,
                        icon: const Icon(Icons.call_end_rounded, size: 32),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.red.shade600,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(20),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'end_call'.tr(context),
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),

                  // Speaker Button
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton.filled(
                        onPressed: () {
                          setState(() {
                            _isSpeakerOn = !_isSpeakerOn;
                          });
                        },
                        icon: Icon(
                          _isSpeakerOn
                              ? Icons.volume_up_rounded
                              : Icons.volume_down_rounded,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: _isSpeakerOn ? AppColors.accent : Colors.white24,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'speaker'.tr(context),
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
