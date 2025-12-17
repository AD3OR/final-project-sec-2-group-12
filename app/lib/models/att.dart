import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  final int studentId;
  final String studentName;
  final String courseId;
  final String routineId;
  final DateTime date;
  final String status;

  Attendance({
    required this.studentId,
    required this.studentName,
    required this.courseId,
    required this.routineId,
    required this.date,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'studentName': studentName,
      'courseId': courseId,
      'routineId': routineId,
      'date': Timestamp.fromDate(date),
      'status': status,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      studentId: map['studentId'],
      studentName: map['studentName'],
      courseId: map['courseId'],
      routineId: map['routineId'],
      date: (map['date'] as Timestamp).toDate(),
      status: map['status'],
    );
  }
}
