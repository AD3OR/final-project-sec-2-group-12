import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/course.dart';

class CourseService {
  final CollectionReference _coursesRef =
      FirebaseFirestore.instance.collection('courses');

  Stream<List<Course>> streamCourses() {
    return _coursesRef.snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => Course.fromDocument(doc)).toList(),
    );
  }

  Future<DocumentReference> addCourse({
    required String name,
    required String code,
  }) {
    return _coursesRef.add({
      'name': name,
      'code': code,
    });
  }

  Future<void> updateCourse(
    String id, {
    required String name,
    required String code,
  }) {
    return _coursesRef.doc(id).update({
      'name': name,
      'code': code,
    });
  }

  Future<void> deleteCourse(String id) {
    return _coursesRef.doc(id).delete();
  }

  Future<Course?> getCourseById(String id) async {
    final doc = await _coursesRef.doc(id).get();
    if (!doc.exists) return null;
    return Course.fromDocument(doc);
  }
}


