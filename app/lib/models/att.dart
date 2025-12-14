class Attendance {
  final int studentId;
  final String courseId;
  final DateTime date;
  final String status; // "Present" or "Absent"

  Attendance({
    required this.studentId,
    required this.courseId,
    required this.date,
    required this.status, required String routineId,
  });

  /// Convert Attendance → Firestore Map
  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'courseId': courseId,
      'date': date.toIso8601String(),
      'status': status,
    };
  }

  /// Convert Firestore Map → Attendance
  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      studentId: map['studentId'],
      courseId: map['courseId'],
      date: DateTime.parse(map['date']),
      status: map['status'], routineId: '',
    );
  }
}
