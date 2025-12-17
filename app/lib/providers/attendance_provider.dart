import 'package:app/models/att.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceProvider with ChangeNotifier {
  final _db = FirebaseFirestore.instance;

  Future<void> saveAttendance(List<Attendance> records) async {
    final batch = _db.batch();

    for (final record in records) {
      final doc = _db.collection('attendance').doc();
      batch.set(doc, record.toMap());
    }

    await batch.commit();
  }

  Stream<List<Attendance>> attendanceByRoutine(
    String routineId,
    DateTime start,
    DateTime end,
  ) {
    return FirebaseFirestore.instance
        .collection('attendance')
        .where('routineId', isEqualTo: routineId)
        .where('date', isGreaterThanOrEqualTo: start)
        .where('date', isLessThan: end)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((d) => Attendance.fromFirestore(d)).toList());
  }
}
