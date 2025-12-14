class Student {
  final int studentId;
  final String studentName;
  final String courseId;

  Student({
    required this.studentId,
    required this.studentName,
    required this.courseId,
  });

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'studentName': studentName,
      'courseId': courseId,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      studentId: map['studentId'],
      studentName: map['studentName'],
      courseId: map['courseId'],
    );
  }
}
