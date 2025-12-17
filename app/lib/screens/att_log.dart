import 'package:app/models/att.dart';
import 'package:app/providers/attendance_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';
import '../widgets/att_tile.dart';

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

          // if (records.isEmpty) {
          //   return const Center(child: Text("No attendance recorded"));
          // }

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          a.studentName,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text("ID: ${a.studentId}"),
                      ],
                    ),
                    Text(
                      a.status,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            a.status == "Present" ? Colors.green : Colors.red,
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
