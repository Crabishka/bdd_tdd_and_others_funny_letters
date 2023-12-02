class DegreeMeasure {
  final int degrees;
  final int minutes;

  final int seconds;

  DegreeMeasure({
    required this.degrees,
    this.minutes = 0,
    this.seconds = 0,
  });

  @override
  String toString() {
    return '$degrees°$minutes\'$seconds"';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DegreeMeasure &&
          runtimeType == other.runtimeType &&
          degrees == other.degrees &&
          minutes == other.minutes &&
          seconds == other.seconds;

  @override
  int get hashCode => degrees.hashCode ^ minutes.hashCode ^ seconds.hashCode;

  DegreeMeasure operator +(DegreeMeasure other) {
    int seconds = (this.seconds + other.seconds) % 60;
    int minutes = this.minutes + other.minutes + ((this.seconds + other.seconds) ~/ 60);
    int degree = degrees + other.degrees + (minutes ~/ 60);
    minutes = minutes % 60;

    return DegreeMeasure(degrees: degree, seconds: seconds, minutes: minutes);
  }

  DegreeMeasure operator -(DegreeMeasure other) {
    int seconds = this.seconds - other.seconds;
    int minutes = this.minutes - other.minutes;
    if (seconds < 0) {
      minutes--;
      seconds += 60;
    }
    int degree = degrees - other.degrees;
    if (minutes < 0) {
      degree--;
      minutes += 60;
    }
    if (degree < 0) {
      degree++;
      minutes -= 60;
    }

    return DegreeMeasure(degrees: degree, seconds: seconds, minutes: minutes);
  }
}
