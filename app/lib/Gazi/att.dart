import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/student_provider.dart';
import '../providers/attendance_provider.dart';

const Color c1 = Color(0xFF696D7D);
const Color c2 = Color(0xFF6F9283);
const Color c3 = Color(0xFF8D9F87);
const Color c4 = Color(0xFFCDC6A5);
const Color c5 = Color(0xFFF0DCCA);

class AttendancePage extends StatefulWidget {
  final String courseId;
  const AttendancePage({super.key, required this.courseId});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  String today = DateTime.now().toString().split(" ")[0];

  @override
  void initState() {
    super.initState();

    final sp = Provider.of<StudentProvider>(context, listen: false);
    final ap = Provider.of<AttendanceProvider>(context, listen: false);

    sp.fetchStudents(widget.courseId);
    ap.loadAttendance(widget.courseId, today);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c4,
      appBar: AppBar(
        backgroundColor: c2,
        title: Text(
          "Attendance ($today)",
          style: const TextStyle(color: c5),
        ),
        iconTheme: const IconThemeData(color: c5),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: c2,
        child: const Icon(Icons.save, color: c5),
        onPressed: () {
          Provider.of<AttendanceProvider>(context, listen: false)
              .saveAttendance(widget.courseId, today);
        },
      ),
      body: Consumer2<StudentProvider, AttendanceProvider>(
        builder: (context, sp, ap, _) {
          return ListView.builder(
            itemCount: sp.students.length,
            itemBuilder: (_, i) {
              final student = sp.students[i];
              final id = student['studentId'];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  tileColor: c4.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  title: Text(
                    student['studentName'],
                    style: const TextStyle(color: c1, fontWeight: FontWeight.bold),
                  ),
                  trailing: ToggleButtons(
                    renderBorder: true,
                    borderColor: c1,
                    selectedColor: c5,
                    fillColor: c3,
                    selectedBorderColor: c1,
                    splashColor: c2.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(6.0),
                    constraints: const BoxConstraints(minHeight: 36.0, minWidth: 48.0),
                    isSelected: [
                      ap.attendanceStatus[id] == "Present",
                      ap.attendanceStatus[id] == "Absent"
                    ],
                    onPressed: (index) {
                      ap.mark(id, index == 0 ? "Present" : "Absent");
                    },
                    children: const [
                      Text("P"),
                      Text("A"),
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