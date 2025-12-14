import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../models/routine.dart';
import '../providers/routine_provider.dart';
import '../theme/colors.dart' as colors;
import 'add_edit_routine_screen.dart';
import 'student_screen.dart';
import '../widgets/routine_tile.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;
  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final routineProvider = Provider.of<RoutineProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: colors.c5,
      appBar: AppBar(
        backgroundColor: colors.c2,
        title: Text(
          course.name,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.group),
            tooltip: "Manage Students",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StudentScreen(courseId: course.id),
                ),
              );
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: colors.c2,
        tooltip: "Add Routine",
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("Something went wrong"));
          }

          final routines = snapshot.data!
              .where((r) => r.courseId == course.id)
              .toList();

          if (routines.isEmpty) {
            return const Center(
              child: Text("No routines added yet"),
            );
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
