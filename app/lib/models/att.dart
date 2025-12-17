import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  final int studentId;
  final String studentName;
  final String status;
  final DateTime date;
  final String routineId;
  final String courseId;

  Attendance({
    required this.studentId,
    required this.studentName,
    required this.status,
    required this.date,
    required this.routineId,
    required this.courseId,
  });

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'studentName': studentName,
      'status': status,
      'date': Timestamp.fromDate(date),
      'routineId': routineId,
      'courseId': courseId,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
  return Attendance(
    studentId: map['studentId'],
    studentName: map['studentName'] ?? '',
    status: map['status'],
    date: (map['date'] as Timestamp).toDate(),
    routineId: map['routineId'],
    courseId: map['courseId'],
  );
}
}

