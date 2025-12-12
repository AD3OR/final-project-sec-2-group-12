// lib/providers/course_provider.dart

import 'package:flutter/material.dart';
import '../models/course.dart';
import '../services/course_service.dart';

class CourseProvider extends ChangeNotifier {
  final CourseService _service = CourseService();

  // Stream all courses
  Stream<List<Course>> get coursesStream => _service.streamCourses();

  // Add a new course
  Future<void> addCourse(
    String name,
    String code,
    String day,
    String startTime,
    String endTime,
  ) async {
    await _service.addCourse(
      name: name,
      code: code,
      day: day,
      startTime: startTime,
      endTime: endTime,
    );
  }

  // Update an existing course
  Future<void> updateCourse(
    String id,
    String name,
    String code,
    String day,
    String startTime,
    String endTime,
  ) async {
    await _service.updateCourse(
      id,
      name: name,
      code: code,
      day: day,
      startTime: startTime,
      endTime: endTime,
    );
  }

  // Delete course
  Future<void> deleteCourse(String id) async {
    await _service.deleteCourse(id);
  }

  // Get course by ID
  Future<Course?> getCourseById(String id) async {
    return await _service.getCourseById(id);
  }
}

