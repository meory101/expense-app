import 'package:flutter/material.dart';
import 'dart:async';

import 'package:tasty_booking/wdgets/app_text.dart';


class TimerWidget extends StatefulWidget {
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int _seconds = 30;
  Timer _timer =Timer(const Duration(seconds: 1), () { });

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_seconds == 0) {
          timer.cancel();
        } else {
          setState(() {
            _seconds--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppText(text: '00:$_seconds',color: const Color(0XFFF75555),fontWeight: FontWeight.w500,fontSize: 14,);
  }
}
