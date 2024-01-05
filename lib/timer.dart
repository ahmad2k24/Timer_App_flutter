import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:timer/widgets/button.dart';

class TimerScreen extends StatefulWidget {
  final int setSeconds, setMinutes, setHours;

  const TimerScreen({
    super.key,
    required this.setSeconds,
    required this.setMinutes,
    required this.setHours,
  });

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late int seconds, minutes, hours, totalTime;
  String systemTime = DateFormat("hh : mm a").format(DateTime.now());
  bool isStart = false;
  double percent = 1;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    seconds = widget.setSeconds;
    minutes = widget.setMinutes;
    hours = widget.setHours;
    totalTime = (hours * 3600) + (minutes * 60) + seconds;
    stopStartTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  //start and stop timer
  void stopStartTimer() {
    if (isStart) {
      timer.cancel();
    } else {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (totalTime < 1) {
          Navigator.of(context).pop();
        } else {
          setState(() {
            totalTime--;
            percent -= (percent / totalTime);
          });
        }
      });
    }
    setState(() {
      isStart = !isStart;
    });
  }

  //timer fuction
  String formatTime(int timeInSeconds) {
    Duration duration = Duration(seconds: timeInSeconds);

    String hours = duration.inHours.remainder(100).toString().padLeft(2, '0');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    if (duration.inHours > 0) {
      return '$hours:$minutes:$seconds';
    } else if (duration.inMinutes > 0) {
      return '$minutes:$seconds';
    } else {
      return seconds;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          actions: const [
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ))
          ]),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              CircularPercentIndicator(
                percent: percent,
                radius: 180,
                lineWidth: 8,
                backgroundWidth: 4,
                progressColor:
                    percent < 0.03 ? Colors.red : Colors.deepPurpleAccent,
                circularStrokeCap: CircularStrokeCap.round,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      formatTime(totalTime),
                      style: const TextStyle(
                          fontSize: 80, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.notifications,
                          size: 20,
                        ),
                        Text(
                          systemTime.toString(),
                          style: const TextStyle(fontSize: 17),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 220,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                      height: 50,
                      width: 120,
                      color: Colors.grey.shade500.withOpacity(0.3),
                      title: "Cancel",
                      onTap: () {
                        Navigator.of(context).pop();
                      }),
                  const SizedBox(
                    width: 110,
                  ),
                  Button(
                      height: 50,
                      width: 120,
                      color: isStart
                          ? Colors.red.shade400.withOpacity(0.3)
                          : Colors.deepPurpleAccent.withOpacity(0.3),
                      title: isStart ? "Pause" : "Resume",
                      onTap: () {
                        stopStartTimer();
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
