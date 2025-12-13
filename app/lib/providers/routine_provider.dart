import 'package:flutter/material.dart';
import '../models/routine.dart';
import '../services/routine_service.dart';

class RoutineProvider extends ChangeNotifier {
  final RoutineService _service = RoutineService();

  // Stream all routines
  Stream<List<Routine>> get routinesStream => _service.streamRoutines();

  // Add routine
  Future<void> addRoutine({
    required String courseId,
    required String day,
    required String startTime,
    required String endTime,
  }) async {
    await _service.addRoutine(
      courseId: courseId,
      day: day,
      startTime: startTime,
      endTime: endTime,
    );
  }

  // Update routine
  Future<void> updateRoutine({
    required String id,
    required String day,
    required String startTime,
    required String endTime,
  }) async {
    await _service.updateRoutine(
      id: id,
      day: day,
      startTime: startTime,
      endTime: endTime,
    );
  }

  // Delete routine
  Future<void> deleteRoutine(String id) async {
    await _service.deleteRoutine(id);
  }
}

