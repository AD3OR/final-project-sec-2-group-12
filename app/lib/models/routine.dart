import 'package:cloud_firestore/cloud_firestore.dart';

class Routine {
  final String id;
  final String courseId;
  final String day;
  final String startTime;
  final String endTime;

  Routine({
    required this.id,
    required this.courseId,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  factory Routine.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return Routine(
      id: doc.id,
      courseId: data['courseId'] ?? '',
      day: data['day'] ?? '',
      startTime: data['startTime'] ?? '',
      endTime: data['endTime'] ?? '',
    );
  }
}


