import 'dart:async';

import 'package:analog_clock/analog_clock_painter.dart';
import 'package:flutter/material.dart';
import 'package:quiver/async.dart';
import 'package:timer/component/imageButton.dart';
import 'package:timer/util/timeExt.dart';

class TimerWidget extends StatefulWidget {
  TimerWidget({Key key}) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  StreamSubscription subscription;
  DateTime startTime;
  bool isPaused = true;
  Duration interval1 = Duration(seconds: 30);
  Duration interval2 = Duration(seconds: 60);
  int secondsLeft = 0;
  int secondsPassed = 0;
  bool isFirstInterval = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final datetime = DateTime(
        0, 0, 0, 0, secondsPassed.getMinutes(), secondsPassed.getSeconds());
//    rebuildAllChildren(context);
    return Column(
      children: <Widget>[
        SizedBox(height: 50),
        ClockWidget(datetime: datetime),
        SizedBox(height: 15),
        Text(
          '${secondsLeft.getMinutes().twoDigits()} : ${secondsLeft.getSeconds().twoDigits()}',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ImageButton(Icons.settings_backup_restore, () => reset()),
            ImageButton(
                (isPaused) ? Icons.play_arrow : Icons.pause, () => pause()),
            ImageButton(Icons.skip_next, () => next()),
          ],
        )
      ],
    );
  }

  void startWithDuration(Duration interval) {
    secondsLeft = interval.inSeconds;
    subscription?.cancel();
    final countdown = CountdownTimer(interval, Duration(milliseconds: 300));
    subscription = countdown.listen((duration) {
      secondsLeft = duration.remaining.inSeconds + 1;
      secondsPassed = duration.elapsed.inSeconds;
      debugPrint(
          'secondsLeft: $secondsLeft   -   secondsPassed: $secondsPassed');
      setState(() {});
    });
    subscription.onDone(() => completed());
    startTime = DateTime.now();
    isPaused = false;
    setState(() {});
  }

  void start() {
    secondsPassed = 0;
    startWithDuration((isFirstInterval) ? interval1 : interval2);
  }

  void next() {
    completed();
  }

  void reset() {
    if(isPaused) {
      secondsPassed = 0;
      secondsLeft = ((isFirstInterval) ? interval1 : interval2).inSeconds;
      setState(() {});
    } else {
      start();
    }
  }

  void pause() {
    isPaused = !isPaused;
    if (isPaused)
      subscription?.pause();
    else {
      (subscription != null) ? subscription.resume() : start();
    }
    setState(() {});
  }

  void completed() {
    subscription?.cancel();
    subscription = null;
    isFirstInterval = !isFirstInterval;
    start();
  }
}

class ClockWidget extends StatelessWidget {
  final DateTime datetime;
  final bool showDigitalClock;
  final bool showTicks;
  final bool showNumbers;
  final bool showAllNumbers;
  final bool showSecondHand;
  final Color hourHandColor;
  final Color minuteHandColor;
  final Color secondHandColor;
  final Color tickColor;
  final Color digitalClockColor;
  final Color numberColor;
  final bool isLive;
  final double textScaleFactor;
  final double width;
  final double height;
  final BoxDecoration decoration;

  const ClockWidget(
      {this.datetime,
      this.showDigitalClock = false,
      this.showTicks = true,
      this.showNumbers = false,
      this.showSecondHand = true,
      this.showAllNumbers = false,
      this.hourHandColor = Colors.transparent,
      this.minuteHandColor = Colors.transparent,
      this.secondHandColor = Colors.redAccent,
      this.tickColor = Colors.grey,
      this.digitalClockColor = Colors.black,
      this.numberColor = Colors.black,
      this.textScaleFactor = 1.0,
      this.width = double.infinity,
      this.height = 300,
      this.decoration = const BoxDecoration(
          color: Colors.transparent, shape: BoxShape.circle),
      this.isLive = false})
      : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: decoration,
      child: Center(
          child: AspectRatio(
              aspectRatio: 1.0,
              child: new Container(
                  constraints: BoxConstraints(minWidth: 48.0, minHeight: 48.0),
                  width: double.infinity,
                  child: new CustomPaint(
                    painter: new AnalogClockPainter(
                        datetime: datetime,
                        showDigitalClock: showDigitalClock,
                        showTicks: showTicks,
                        showNumbers: showNumbers,
                        showAllNumbers: showAllNumbers,
                        showSecondHand: showSecondHand,
                        hourHandColor: hourHandColor,
                        minuteHandColor: minuteHandColor,
                        secondHandColor: secondHandColor,
                        tickColor: tickColor,
                        digitalClockColor: digitalClockColor,
                        textScaleFactor: textScaleFactor,
                        numberColor: numberColor),
                  )))),
    );
  }
}
