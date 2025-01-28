class MedicalRecord {
  final String id;
  final String title;
  final String type;
  final String filePath;
  final DateTime date;
  final String description;

  MedicalRecord({
    required this.id,
    required this.title,
    required this.type,
    required this.filePath,
    required this.date,
    required this.description,
  });
} 