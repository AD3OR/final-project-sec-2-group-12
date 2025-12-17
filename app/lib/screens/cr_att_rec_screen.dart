import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../models/routine.dart';
import '../providers/course_provider.dart';
import '../providers/routine_provider.dart';
import '../theme/colors.dart';
import 'att_log.dart';

class CourseAttendanceRecordScreen extends StatelessWidget {
  const CourseAttendanceRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routineProvider = Provider.of<RoutineProvider>(context, listen: false);
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: c5,
      appBar: AppBar(
        backgroundColor: c2,
        title: const Text(
          "Attendance Records",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: StreamBuilder<List<Course>>(
        stream: courseProvider.coursesStream,
        builder: (context, courseSnapshot) {
          if (!courseSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final courses = courseSnapshot.data!;

          if (courses.isEmpty) {
            return const Center(child: Text("No courses found"));
          }

          return StreamBuilder<List<Routine>>(
            stream: routineProvider.routinesStream,
            builder: (context, routineSnapshot) {
              if (!routineSnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final routines = routineSnapshot.data!;

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];

                  final courseRoutines = routines
                      .where((r) => r.courseId == course.id)
                      .toList();

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: c4,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        if (courseRoutines.isEmpty)
                          const Text("No routines available"),

                        ...courseRoutines.map(
                          (Routine r) => ListTile(
                            title: Text(
                              "${r.day} (${r.startTime} - ${r.endTime})",
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AttendanceLogScreen(
                                    courseId: course.id,
                                    routineId: r.id,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
