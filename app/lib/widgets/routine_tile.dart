import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/routine.dart';
import '../providers/routine_provider.dart';
import '../theme/colors.dart';
import '../screens/add_edit_routine_screen.dart';

class RoutineTile extends StatelessWidget {
  final Routine routine;
  const RoutineTile({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RoutineProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: c4,
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
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text("${routine.startTime} - ${routine.endTime}"),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                color: c2,
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
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.redAccent,
                onPressed: () async {
                  await provider.deleteRoutine(routine.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
