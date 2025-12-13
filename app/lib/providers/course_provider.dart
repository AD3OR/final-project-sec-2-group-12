import 'package:flutter/material.dart';
import '../models/course.dart';
import '../services/course_service.dart';

class CourseProvider extends ChangeNotifier {
  final CourseService _service = CourseService();

  Stream<List<Course>> get coursesStream => _service.streamCourses();

  Future<void> addCourse(String name, String code) async {
    await _service.addCourse(name: name, code: code);
  }

  Future<void> updateCourse(String id, String name, String code) async {
    await _service.updateCourse(id, name: name, code: code);
  }

  Future<void> deleteCourse(String id) async {
    await _service.deleteCourse(id);
  }

  Future<Course?> getCourseById(String id) async {
    return _service.getCourseById(id);
  }
}

