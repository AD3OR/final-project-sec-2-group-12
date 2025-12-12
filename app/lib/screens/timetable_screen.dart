import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';
import '../models/course.dart';
import '../theme/colors.dart';
import 'course_detail_screen.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  final List<String> _days = const [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: c5,
      appBar: AppBar(
        backgroundColor: c2,
        title: const Text("Weekly Timetable", style: TextStyle(color: Colors.white)),
      ),
      body: StreamBuilder<List<Course>>(
        stream: courseProvider.coursesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final courses = snapshot.data!;

          // Group courses by day
          final Map<String, List<Course>> grouped = {};
          for (var day in _days) {
            grouped[day] = courses.where((c) => c.day == day).toList();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _days.length,
            itemBuilder: (context, index) {
              final day = _days[index];
              final dayCourses = grouped[day] ?? [];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    day,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: c1,
                    ),
                  ),
                  const SizedBox(height: 10),

                  if (dayCourses.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 20),
                      child: Text(
                        "No classes",
                        style: TextStyle(color: c1.withOpacity(0.7)),
                      ),
                    ),

                  ...dayCourses.map((course) => _courseCard(context, course)).toList(),

                  const SizedBox(height: 25),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _courseCard(BuildContext context, Course course) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CourseDetailScreen(course: course)),
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
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 4),
            Text(
              course.code,
              style: TextStyle(color: Colors.black.withOpacity(0.7)),
            ),
            const SizedBox(height: 6),
            Text(
              "${course.startTime} - ${course.endTime}",
              style: TextStyle(
                  fontSize: 14, color: Colors.black.withOpacity(0.8)),
            ),
          ],
        ),
      ),
    );
  }
}
