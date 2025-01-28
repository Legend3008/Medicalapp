class Prescription {
  final String id;
  final String name;
  final String medication;
  final String dosage;
  final String instructions;
  final DateTime date;
  final bool isActive;
  final int refillsRemaining;

  Prescription({
    required this.id,
    required this.name,
    required this.medication,
    required this.dosage,
    required this.instructions,
    required this.date,
    required this.isActive,
    required this.refillsRemaining,
  });
} 