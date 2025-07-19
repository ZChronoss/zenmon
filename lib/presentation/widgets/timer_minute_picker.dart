import 'package:flutter/cupertino.dart';

class TimerMinutePicker extends StatelessWidget {
  final int selectedMinute;
  final ValueChanged<int> onMinuteChange;

  const TimerMinutePicker({
    super.key,
    required this.selectedMinute,
    required this.onMinuteChange
  });
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(initialItem: selectedMinute),
        itemExtent: 40, 
        onSelectedItemChanged: onMinuteChange, 
        children: List<Widget>.generate(
          61, 
          (int index) {
            return Center(
              child: Text('$index', style: const TextStyle(fontSize: 20)),
            );
          }
        )
      ),
    );
  }

  
}