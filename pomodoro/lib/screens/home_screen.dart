import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const defaultTime = 1500;
  int totalSeconds = defaultTime;
  bool isPlaying = false;
  int pomodoros = 0;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      timer.cancel();

      setState(() {
        totalSeconds = defaultTime;
        isPlaying = false;
        pomodoros++;
      });

      return;
    }

    setState(() {
      totalSeconds--;
    });
  }

  void onPlayPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );

    setState(() {
      isPlaying = true;
    });
  }

  void onPausePressed() {
    timer.cancel();

    setState(() {
      isPlaying = false;
    });
  }

  void onResetPressed() {
    if (totalSeconds != defaultTime) {
      timer.cancel();

      setState(() {
        totalSeconds = defaultTime;
        isPlaying = false;
      });
    }
  }

  String formatTime(int seconds) {
    var duration = Duration(seconds: seconds);

    return duration.toString().split('.').first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                formatTime(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 90,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: isPlaying ? onPausePressed : onPlayPressed,
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_circle_outline,
                  ),
                  iconSize: 120,
                  color: Theme.of(context).cardColor,
                ),
                const SizedBox(height: 20),
                totalSeconds != defaultTime
                    ? IconButton(
                        onPressed: onResetPressed,
                        icon: Icon(Icons.refresh,
                            color: Theme.of(context).cardColor),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "POMODOROS",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color),
                        ),
                        Text(
                          pomodoros.toString(),
                          style: TextStyle(
                              fontSize: 56,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
