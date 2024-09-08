import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('lib/assets/timer.json',
            height: 80,
            width: 200),
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
        return Container(
          padding: EdgeInsets.all(20),
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200]
          ),
          child: Column(
            children: [
              Text(
                timer.currentMode == TimerMode.work ? 'Work Time' : 'Break Time',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                )
                //Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                '$minutes:$seconds',
                style:TextStyle(
                  fontSize: 40,
                  fontWeight:FontWeight.bold
                )
                // Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
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
        return Container(
          padding: EdgeInsets.all(12),
          width: 300,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[200]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: timer.isRunning ? null : timer.startTimer,
               icon: Icon(Icons.play_circle_filled,
               color: Colors.pink[600],
               size: 35,)),
              // ElevatedButton(
              //   onPressed: timer.isRunning ? null : timer.startTimer,
              //   child: const Text('Start'),
              // ),
              const SizedBox(width: 20),
              IconButton(onPressed:  timer.isRunning ? timer.stopTimer : null,
               icon:Icon(Icons.stop_circle_sharp,
               size: 35,
               color: Colors.pink[600],)),
          
              // ElevatedButton(
              //   onPressed: timer.isRunning ? timer.stopTimer : null,
              //   child: const Text('Stop'),
              // ),
              const SizedBox(width: 20),
              IconButton(onPressed: timer.resetTimer,
               icon:Icon(Icons.repeat_sharp,
               color: Colors.pink[600],
               size: 35,)),
          
              // ElevatedButton(
              //   onPressed: timer.resetTimer,
              //   child: const Text('Reset'),
              // ),
            ],
          ),
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