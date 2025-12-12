// lib/screens/course_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../models/routine.dart';
import '../providers/routine_provider.dart';
import '../widgets/routine_tile.dart';
import 'add_edit_routine_screen.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;
  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final routineProvider = Provider.of<RoutineProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text(course.name)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(child: Text(course.code, style: const TextStyle(fontSize: 16))),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddEditRoutineScreen(courseId: course.id),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Routine'),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Routine>>(
              stream: routineProvider.routinesForCourse(course.id),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final routines = snapshot.data ?? [];
                if (routines.isEmpty) {
                  return const Center(child: Text('No routines yet.'));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: routines.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, i) {
                    return RoutineTile(routine: routines[i]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
