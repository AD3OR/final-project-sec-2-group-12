// lib/models/routine.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Routine {
  final String id;
  final String name;
  final String day;
  final String startTime;
  final String endTime;
  final String courseId;

  Routine({
    required this.id,
    required this.name,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.courseId,
  });

  factory Routine.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return Routine(
      id: doc.id,
      name: data['name'] ?? '',
      day: data['day'] ?? '',
      startTime: data['startTime'] ?? '',
      endTime: data['endTime'] ?? '',
      courseId: data['courseId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
      'courseId': courseId,
    };
  }
}

