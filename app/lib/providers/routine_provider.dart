// lib/providers/routine_provider.dart
import 'package:flutter/material.dart';
import '../models/routine.dart';
import '../services/routine_service.dart';

class RoutineProvider extends ChangeNotifier {
  final RoutineService _service = RoutineService();

  Stream<List<Routine>> routinesForCourse(String courseId) {
    return _service.streamRoutinesForCourse(courseId);
  }

  Future<void> addRoutine(Routine routine) async {
    await _service.addRoutine(routine);
  }

  Future<void> updateRoutine(String id, Routine routine) async {
    await _service.updateRoutine(id, routine);
  }

  Future<void> deleteRoutine(String id) async {
    await _service.deleteRoutine(id);
  }
}
