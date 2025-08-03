import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zenmon/presentation/widgets/custom_alert_dialog.dart';
import 'package:zenmon/presentation/widgets/timer_minute_picker.dart';

class FocusTimer extends StatefulWidget {
  final Duration duration;
  final void Function(int elapsedMinutes)? onFinished;

  const FocusTimer({
    super.key,
    required this.duration,
    this.onFinished
  });

  @override
  State<StatefulWidget> createState() => _FocusTimerState();
}

class _FocusTimerState extends State<FocusTimer> {
  late Duration _remaining;
  late Duration _initialDuration;
  Timer? _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _remaining = widget.duration;
    _initialDuration = widget.duration; // Initialize _initialDuration
  }

  // This method is called whenever the widget's configuration changes.
  // We use it to update _remaining if the parent widget passes a new duration.
  @override
  void didUpdateWidget(covariant FocusTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration && !_isRunning) {
      // Only update _remaining if the timer is not running
      // and the duration from the parent has changed.
      _remaining = widget.duration;
    }
  }

  void _startTimer() {
    if (_isRunning) return;

    _isRunning = true;
    _initialDuration = _remaining;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(_remaining.inSeconds <= 1) {
        timer.cancel();
        _isRunning = false;

        final elapsedMinutes = _getElapsedMinutes();
        if (widget.onFinished != null) {
          widget.onFinished!(elapsedMinutes); // Pass elapsed minutes
        }
        // Ensure the UI updates to show 00:00 when finished
        setState(() {
          _remaining = Duration.zero;
        });
        return; // Exit after cancelling to prevent negative duration
      }

      setState(() {
        _remaining -= const Duration(seconds: 1);
      });
    });
  }

  void _resetTimer() {
    _timer?.cancel();

    // Calculate elapsed minutes before resetting
    final elapsedMinutes = _getElapsedMinutes();
    if (widget.onFinished != null && elapsedMinutes > 0) {
      widget.onFinished!(elapsedMinutes); 
    }

    setState(() {
      _remaining = widget.duration;
      _isRunning = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

    // Extracted: Minute Picker Widget
  Widget _buildMinutePicker() {
    return TimerMinutePicker(
      selectedMinute: _remaining.inMinutes,
      onMinuteChange: (minute) {
        setState(() {
          _remaining = Duration(minutes: minute);
        });
      }
    );
  }

    // Extracted: Timer Text Widget
  Widget _buildTimerText(BuildContext context) {
    final minutes = _remaining.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = _remaining.inSeconds.remainder(60).toString().padLeft(2, '0');
    return Text(
      '$minutes:$seconds',
      style: Theme.of(context).textTheme.displayMedium,
    );
  }

    Widget _buildTimerGestureDetector(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!_isRunning) {
          showModalBottomSheet(
            context: context,
            builder: (context) => _buildMinutePicker(),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Cannot change timer while it's running. Reset first.")),
          );
        }
      },
      child: _buildTimerText(context),
    );
  }

  Widget _buildStartButton() {
    return ElevatedButton(
      onPressed: _isRunning ? null : _startTimer,
      child: const Text("Start Timer"),
    );
  }

  Widget _buildResetButton(BuildContext context) {
    return ElevatedButton(
      onPressed: !_isRunning
          ? null
          : () {
            showDialog(
              context: context, 
              builder: (BuildContext context) {
                return CustomAlertDialog(
                  title: "Are you sure?", 
                  content: "Do you really want to reset the timer?",
                  cancelText: "Cancel",
                  confirmText: "Yes",
                  onCancel: () => Navigator.of(context).pop(),
                  onConfirm: () {
                    Navigator.of(context).pop();
                    _resetTimer();
                  },
                );
              });
            },
      child: const Text("Reset Timer"),
    );
  }

  Widget _buildButtonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStartButton(),
        const SizedBox(width: 8),
        _buildResetButton(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTimerGestureDetector(context),
        const SizedBox(height: 16),
        _buildButtonRow(context)
      ],
    );
  }

  int _getElapsedMinutes() {
    final elapsedSeconds = _initialDuration.inSeconds - _remaining.inSeconds;
    return elapsedSeconds ~/ 60;
  }
}
