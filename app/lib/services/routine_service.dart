import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/routine.dart';

class RoutineService {
  final CollectionReference _routineRef =
      FirebaseFirestore.instance.collection('routines');

  // Stream all routines
  Stream<List<Routine>> streamRoutines() {
    return _routineRef.snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => Routine.fromDocument(doc)).toList(),
    );
  }

  // Add new routine
  Future<void> addRoutine({
    required String courseId,
    required String day,
    required String startTime,
    required String endTime,
  }) async {
    await _routineRef.add({
      'courseId': courseId,
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
    });
  }

  // Update existing routine
  Future<void> updateRoutine({
    required String id,
    required String day,
    required String startTime,
    required String endTime,
  }) async {
    await _routineRef.doc(id).update({
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
    });
  }

  // Delete routine
  Future<void> deleteRoutine(String id) async {
    await _routineRef.doc(id).delete();
  }
}

