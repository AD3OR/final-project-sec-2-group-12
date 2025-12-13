import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../models/routine.dart';
import '../providers/routine_provider.dart';
import '../theme/colors.dart';
import 'add_edit_routine_screen.dart';
import '../widgets/routine_tile.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;
  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final routineProvider = Provider.of<RoutineProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: c5,
      appBar: AppBar(
        backgroundColor: c2,
        title:
            Text(course.name, style: const TextStyle(color: Colors.white)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: c2,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  AddEditRoutineScreen(courseId: course.id),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Routine>>(
        stream: routineProvider.routinesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final routines = snapshot.data!
              .where((r) => r.courseId == course.id)
              .toList();

          if (routines.isEmpty) {
            return const Center(child: Text("No routines added yet"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: routines.length,
            itemBuilder: (context, index) {
              return RoutineTile(routine: routines[index]);
            },
          );
        },
      ),
    );
  }
}
