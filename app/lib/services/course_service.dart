// lib/services/course_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/course.dart';

class CourseService {
  final CollectionReference _coursesRef =
      FirebaseFirestore.instance.collection('courses');

  // Stream all courses
  Stream<List<Course>> streamCourses() {
    return _coursesRef.snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) => Course.fromDocument(doc)).toList();
      },
    );
  }

  // Add new course
  Future<DocumentReference> addCourse({
    required String name,
    required String code,
    required String day,
    required String startTime,
    required String endTime,
  }) {
    final data = {
      'name': name,
      'code': code,
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
    };

    return _coursesRef.add(data);
  }

  // Update existing course
  Future<void> updateCourse(
    String id, {
    required String name,
    required String code,
    required String day,
    required String startTime,
    required String endTime,
  }) {
    final data = {
      'name': name,
      'code': code,
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
    };

    return _coursesRef.doc(id).update(data);
  }

  // Delete course
  Future<void> deleteCourse(String id) {
    return _coursesRef.doc(id).delete();
  }

  // Get single course by ID
  Future<Course?> getCourseById(String id) async {
    final doc = await _coursesRef.doc(id).get();

    if (!doc.exists) return null;

    return Course.fromDocument(doc);
  }
}


