import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:zenmon/presentation/widgets/timer_minute_picker.dart';

class FocusTimer extends StatefulWidget {
  final Duration duration;
  final VoidCallback? onFinished;

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
  Timer? _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _remaining = widget.duration;
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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(_remaining.inSeconds <= 1) {
        timer.cancel();
        _isRunning = false;
        widget.onFinished?.call();
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

  @override
  Widget build(BuildContext context) {
    final minutes = _remaining.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = _remaining.inSeconds.remainder(60).toString().padLeft(2, '0');

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            // Only allow changing time if timer is not running
            if (!_isRunning) {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return TimerMinutePicker(
                    selectedMinute: _remaining.inMinutes, // Use _remaining.inMinutes for current selection
                    onMinuteChange: (minute) {
                      setState(() {
                        _remaining = Duration(minutes: minute);
                      });
                    }
                  );
                },
              );
            } else {
              // Optionally show a message that timer cannot be changed while running
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Cannot change timer while it's running. Reset first.")),
              );
            }
          },
          child: Text(
            '$minutes:$seconds',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _isRunning ? null : _startTimer,
          child: const Text("Start Timer") // Use const for Text widget
        ),
        const SizedBox(height: 8), // Added a small SizedBox for spacing between buttons
        ElevatedButton(
          onPressed: !_isRunning ? null : () {
            // Determine the platform and show the appropriate alert dialog
            if (Theme.of(context).platform == TargetPlatform.iOS) {
              showCupertinoDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: const Text("Are you sure?"),
                    content: const Text("Do you really want to reset the timer?"),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Cancel"),
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true, // Makes the text red for destructive actions
                        onPressed: () {
                          Navigator.of(context).pop();
                          _resetTimer();
                        },
                        child: const Text("Reset"), // Changed to "Reset" for brevity
                      )
                    ],
                  );
                },
              );
            } else {
              // Default Android AlertDialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Are you sure?"),
                    content: const Text("Do you really want to reset the timer?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Cancel")
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _resetTimer();
                        },
                        child: const Text("Yes")
                      )
                    ],
                  );
                },
              );
            }
          },
          child: const Text("Reset Timer")
        )
      ],
    );
  }
}
