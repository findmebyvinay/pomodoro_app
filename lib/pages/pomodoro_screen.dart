import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro/provider/pomodoro_timer.dart';

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro Timer'),
        centerTitle: true,
      ),
      backgroundColor: Colors.purpleAccent[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            TimerDisplay(),
            SizedBox(height: 20),
            TimerControls(),
            SizedBox(height: 20),
            TimerSettings(),
          ],
        ),
      ),
    );
  }
}

class TimerDisplay extends StatelessWidget {
  const TimerDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroTimer>(
      builder: (context, timer, child) {
        final minutes = (timer.timeLeft ~/ 60).toString().padLeft(2, '0');
        final seconds = (timer.timeLeft % 60).toString().padLeft(2, '0');
        return Column(
          children: [
            Text(
              timer.currentMode == TimerMode.work ? 'Work Time' : 'Break Time',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              '$minutes:$seconds',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        );
      },
    );
  }
}

class TimerControls extends StatelessWidget {
  const TimerControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroTimer>(
      builder: (context, timer, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: timer.isRunning ? null : timer.startTimer,
              child: const Text('Start'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: timer.isRunning ? timer.stopTimer : null,
              child: const Text('Stop'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: timer.resetTimer,
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }
}

class TimerSettings extends StatelessWidget {
  const TimerSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroTimer>(
      builder: (context, timer, child) {
        return Column(
          children: [
            Text('Work Duration: ${timer.workDuration ~/ 60} minutes'),
            // Slider(
            //   value: timer.workDuration.toDouble(),
            //   min: 600,
            //   max: 900,
            //   divisions: 8,
            //   label: '${timer.workDuration ~/ 60} minutes',
            //   onChanged: (value) => timer.setWorkDuration(value.toInt()),
            // ),
            // Text('Short Break: ${timer.shortBreakDuration ~/ 60} minutes'),
            // Slider(
            //   value: timer.shortBreakDuration.toDouble(),
            //   min: 300,
            //   max: 600,
            //   divisions: 1,
            //   label: '${timer.shortBreakDuration ~/ 60} minutes',
            //   onChanged: (value) => timer.setShortBreakDuration(value.toInt()),
            // ),
            // Text('Long Break: ${timer.longBreakDuration ~/ 60} minutes'),
            // Slider(
            //   value: timer.longBreakDuration.toDouble(),
            //   min: 300,
            //   max: 600,
            //   divisions: 1,
            //   label: '${timer.longBreakDuration ~/ 60} minutes',
            //   onChanged: (value) => timer.setLongBreakDuration(value.toInt()),
            // ),
          ],
        );
      },
    );
  }
}