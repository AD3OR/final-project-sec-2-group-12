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
    DateTime date,
  ) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));

    return _db
        .collection('attendance')
        .where('routineId', isEqualTo: routineId)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('date', isLessThan: Timestamp.fromDate(end))
        .snapshots()
        .map((snap) =>
            snap.docs.map((d) => Attendance.fromMap(d.data())).toList());
  }
}

