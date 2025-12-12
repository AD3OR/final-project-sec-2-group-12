// lib/services/routine_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/routine.dart';

class RoutineService {
  final CollectionReference _routinesRef =
      FirebaseFirestore.instance.collection('routines');

  Stream<List<Routine>> streamRoutinesForCourse(String courseId) {
    return _routinesRef
        .where('courseId', isEqualTo: courseId)
        .orderBy('day')
        .snapshots()
        .map((snap) => snap.docs.map((d) => Routine.fromDocument(d)).toList());
  }

  Future<DocumentReference> addRoutine(Routine routine) {
    return _routinesRef.add(routine.toMap());
  }

  Future<void> updateRoutine(String id, Routine routine) {
    return _routinesRef.doc(id).update(routine.toMap());
  }

  Future<void> deleteRoutine(String id) {
    return _routinesRef.doc(id).delete();
  }
}
