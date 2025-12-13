import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';
import '../models/course.dart';
import '../theme/colors.dart';
import 'course_detail_screen.dart';

class CourseSelectRoutineScreen extends StatelessWidget {
  const CourseSelectRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: c5,
      appBar: AppBar(
        backgroundColor: c2,
        title: const Text(
          "Select Course for Routine",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<List<Course>>(
        stream: courseProvider.coursesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final courses = snapshot.data!;

          if (courses.isEmpty) {
            return const Center(child: Text("No courses available"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CourseDetailScreen(course: course),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: c4,
                    borderRadius: BorderRadius.circular(12),
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
                      Text(
                        course.code,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
