import 'dart:async';

class Temporizador {
  late Timer _timer;
  late Duration _timeLeft;
  final Duration duration; // Duración inicial del temporizador
  final Function(Duration) onTick; // Callback para notificar cada tick
  final Function onComplete; // Callback para notificar cuando el tiempo llegue a 0

  Temporizador({
    required this.duration,
    required this.onTick,
    required this.onComplete,
  }) {
    _timeLeft = duration;
  }

  void start() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft.inSeconds > 0) {
        _timeLeft -= Duration(seconds: 1);
        onTick(_timeLeft);
      } else {
        _timer.cancel();
        onComplete();
      }
    });
  }

  void reset(Duration newDuration) {
    stop();
    _timeLeft = newDuration;
    start();
  }

  void stop() {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }

  Duration get timeLeft => _timeLeft;
}
