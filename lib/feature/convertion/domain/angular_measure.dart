class AngularMeasure {
  final int largeDivision;
  final int smallDivision;

  AngularMeasure({
    required this.largeDivision,
    required this.smallDivision,
  });

  @override
  String toString() {
    return '$largeDivision-$smallDivision';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AngularMeasure &&
          runtimeType == other.runtimeType &&
          largeDivision == other.largeDivision &&
          smallDivision == other.smallDivision;

  @override
  int get hashCode => largeDivision.hashCode ^ smallDivision.hashCode;

  AngularMeasure operator +(AngularMeasure other) {
    final newSmallDivision = (smallDivision + other.smallDivision) % 100;
    final newLargeDivision = largeDivision + other.largeDivision + (smallDivision + other.smallDivision).abs() ~/ 100;
    return AngularMeasure(largeDivision: newLargeDivision, smallDivision: newSmallDivision);
  }

  AngularMeasure operator -(AngularMeasure other) {
    final newSmallDivision = (smallDivision - other.smallDivision) % 100;
    final newLargeDivision = largeDivision - other.largeDivision + ((smallDivision - other.smallDivision) < 0 ? -1 : 0);
    return AngularMeasure(largeDivision: newLargeDivision, smallDivision: newSmallDivision);
  }
}
