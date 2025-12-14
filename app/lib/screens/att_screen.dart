import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/att.dart';

// Color Palette
const Color c1 = Color(0xFF696D7D);
const Color c2 = Color(0xFF6F9283);
const Color c3 = Color(0xFF8D9F87);
const Color c4 = Color(0xFFCDC6A5);
const Color c5 = Color(0xFFF0DCCA);

class AttendanceScreen extends StatefulWidget {
  final String courseId;
  final String routineId;
  final DateTime date;

  const AttendanceScreen({
    super.key,
    required this.courseId,
    required this.routineId,
    required this.date,
  });

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  /// studentId -> present/absent
  final Map<int, bool> attendanceStatus = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c5,
      appBar: AppBar(
        backgroundColor: c2,
        title: const Text(
          "Take Attendance",
          style: TextStyle(color: Colors.white),
        ),
      ),

      // ================= STUDENT LIST =================
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("students")
            .where("courseId", isEqualTo: widget.courseId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No students found"));
          }

          final students = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: students.length,
            itemBuilder: (context, index) {
              final data =
                  students[index].data() as Map<String, dynamic>;

              final String studentName =
                  data['studentName'] ?? 'No Name';
              final int studentId =
                  data['studentId']; // ✅ consistent key

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: c3,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            studentName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "ID: $studentId",
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),

                    Checkbox(
                      activeColor: c1,
                      value: attendanceStatus[studentId] ?? false,
                      onChanged: (value) {
                        setState(() {
                          attendanceStatus[studentId] = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),

      // ================= SUBMIT BUTTON =================
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: c1,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: _submitAttendance,
          child: const Text(
            "Submit Attendance",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }

  // ================= SUBMIT LOGIC =================
  void _submitAttendance() {
    final List<Attendance> records =
        attendanceStatus.entries.map((entry) {
      return Attendance(
        studentId: entry.key,
        courseId: widget.courseId,
        routineId: widget.routineId,
        date: widget.date,
        status: entry.value ? "Present" : "Absent",
      );
    }).toList();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "${records.length} attendance records prepared",
        ),
      ),
    );

    // Next step:
    // AttendanceProvider.saveAttendance(records);
  }
}
