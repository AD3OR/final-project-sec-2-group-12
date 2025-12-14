import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<Map<String, dynamic>> students = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

// Fetch
  Future<void> fetchStudents(String courseId) async {
    _isLoading = true;
    notifyListeners();

    final snapshot = await _db
        .collection('students')
        .where('courseId', isEqualTo: courseId)
        .get();

    students = snapshot.docs.map((doc) {
      return {
        'docId': doc.id, // IMPORTANT
        ...doc.data(),
      };
    }).toList();

    _isLoading = false;
    notifyListeners();
  }
// Add
  Future<void> addStudent(
    String courseId,
    String name,
    String id,
  ) async {
    await _db.collection('students').add({
      'studentName': name,
      'studentId': int.parse(id),
      'courseId': courseId,
    });

    await fetchStudents(courseId);
  }

// Edit
  Future<void> editStudent(
    String docId,
    String courseId,
    String newName,
  ) async {
    await _db.collection('students').doc(docId).update({
      'studentName': newName,
    });

    final index = students.indexWhere((s) => s['docId'] == docId);
    if (index != -1) {
      students[index]['studentName'] = newName;
      notifyListeners();
    }
  }

// Delete
  Future<void> deleteStudent(
    String docId,
    String courseId,
  ) async {
    await _db.collection('students').doc(docId).delete();
    await fetchStudents(courseId);
  }
}
