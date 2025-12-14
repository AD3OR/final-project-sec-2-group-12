import 'package:flutter/material.dart';

import '../models/routine.dart';
import '../screens/att_screen.dart';
import '../screens/add_edit_routine_screen.dart';
import '../theme/colors.dart' as colors;

class RoutineTile extends StatelessWidget {
  final Routine routine;

  const RoutineTile({
    super.key,
    required this.routine,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AttendanceScreen(
              courseId: routine.courseId,
              routineId: routine.id,
              date: DateTime.now(),
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.c4,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  routine.day,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${routine.startTime} - ${routine.endTime}",
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  color: colors.c2,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddEditRoutineScreen(
                          editingRoutine: routine,
                          courseId: routine.courseId,
                        ),
                      ),
                    );
                  },
                ),
                const Icon(
                  Icons.check_circle_outline,
                  color: colors.c2,
                  size: 28,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
