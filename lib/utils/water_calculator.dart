/// Educational formula only - not a medical standard.
double calculateWaterLitres({
  required int weightKg,
  required double activityHours,
}) {
  final double baseMl = weightKg * 35; // base need
  final double activityMl = activityHours * 250; // activity extra
  final double totalMl = baseMl + activityMl; // total in ml
  return totalMl / 1000; // litres
}
