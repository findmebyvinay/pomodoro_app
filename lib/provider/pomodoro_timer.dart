import 'dart:async';
import 'package:flutter/foundation.dart';

enum TimerMode { work, shortBreak, longBreak }

class PomodoroTimer with ChangeNotifier {
  int _timeLeft = 25 * 60; // 25 minutes in seconds
  bool _isRunning = false;
  TimerMode _currentMode = TimerMode.work;
  Timer? _timer;

  int _workDuration = 25 * 60;
  int _shortBreakDuration = 5 * 60;
  int _longBreakDuration = 15 * 60;

  int get timeLeft => _timeLeft;
  bool get isRunning => _isRunning;
  TimerMode get currentMode => _currentMode;
  int get workDuration => _workDuration;
  int get shortBreakDuration => _shortBreakDuration;
  int get longBreakDuration => _longBreakDuration;

  void startTimer() {
    if (!_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(Duration(seconds: 1), (_) => _tick());
      notifyListeners();
    }
  }

  void stopTimer() {
    if (_isRunning) {
      _isRunning = false;
      _timer?.cancel();
      notifyListeners();
    }
  }

  void resetTimer() {
    stopTimer();
    _timeLeft = _getDurationForCurrentMode();
    notifyListeners();
  }

  void _tick() {
    if (_timeLeft > 0) {
      _timeLeft--;
    } else {
      _switchMode();
    }
    notifyListeners();
  }

  void _switchMode() {
    stopTimer();
    switch (_currentMode) {
      case TimerMode.work:
        _currentMode = TimerMode.shortBreak;
        break;
      case TimerMode.shortBreak:
      case TimerMode.longBreak:
        _currentMode = TimerMode.work;
        break;
    }
    _timeLeft = _getDurationForCurrentMode();
    notifyListeners();
  }

  int _getDurationForCurrentMode() {
    switch (_currentMode) {
      case TimerMode.work:
        return _workDuration;
      case TimerMode.shortBreak:
        return _shortBreakDuration;
      case TimerMode.longBreak:
        return _longBreakDuration;
    }
  }

  void setWorkDuration(int minutes) {
    _workDuration = minutes * 60;
    if (_currentMode == TimerMode.work) {
      resetTimer();
    }
    notifyListeners();
  }

  void setShortBreakDuration(int minutes) {
    _shortBreakDuration = minutes * 60;
    if (_currentMode == TimerMode.shortBreak) {
      resetTimer();
    }
    notifyListeners();
  }

  void setLongBreakDuration(int minutes) {
    _longBreakDuration = minutes * 60;
    if (_currentMode == TimerMode.longBreak) {
      resetTimer();
    }
    notifyListeners();
  }
}