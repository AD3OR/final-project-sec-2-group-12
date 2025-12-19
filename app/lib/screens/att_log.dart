import 'package:app/models/att.dart';
import 'package:app/providers/attendance_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../theme/colors.dart';

class AttendanceLogScreen extends StatelessWidget {
  final String routineId;
  final String courseId;

  const AttendanceLogScreen({
    super.key,
    required this.courseId,
    required this.routineId,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AttendanceProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: c5,
      appBar: AppBar(
        backgroundColor: c2,
        title: const Text("Attendance Log"),
      ),
      body: StreamBuilder<List<Attendance>>(
        stream: provider.attendanceByRoutine(routineId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No attendance recorded"));
          }

          final records = snapshot.data!;
          final dateFormatter = DateFormat('dd MMM yyyy • hh:mm a');

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: records.length,
            itemBuilder: (context, index) {
              final a = records[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: a.status == "Present"
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ───── Student Name ─────
                    Text(
                      a.studentName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // ───── Student ID ─────
                    Text(
                      "ID: ${a.studentId}",
                      style: const TextStyle(fontSize: 14),
                    ),

                    const SizedBox(height: 6),

                    // ───── Date ─────
                    Text(
                      dateFormatter.format(a.date),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ───── Status Badge ─────
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        a.status,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: a.status == "Present"
                              ? Colors.green.shade800
                              : Colors.red.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
