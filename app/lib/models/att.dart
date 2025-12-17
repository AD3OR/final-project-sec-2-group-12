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

  factory Attendance.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();

    return Attendance(
      studentId: data['studentId'],
      studentName: data['studentName'],
      courseId: data['courseId'],
      routineId: data['routineId'],
      date: (data['date'] as Timestamp).toDate(),
      status: data['status'],
    );
  }

  // optional 
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
}
