import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';
import '../models/course.dart';
import '../theme/colors.dart';

class AddEditCourseScreen extends StatefulWidget {
  final Course? editingCourse;
  const AddEditCourseScreen({super.key, this.editingCourse});

  @override
  State<AddEditCourseScreen> createState() => _AddEditCourseScreenState();
}

class _AddEditCourseScreenState extends State<AddEditCourseScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  final _startCtrl = TextEditingController();
  final _endCtrl = TextEditingController();

  String _day = "Monday";
  final List<String> _days = [
    "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
  ];

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.editingCourse != null) {
      final c = widget.editingCourse!;
      _nameCtrl.text = c.name;
      _codeCtrl.text = c.code;
      _day = c.day;
      _startCtrl.text = c.startTime;
      _endCtrl.text = c.endTime;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _codeCtrl.dispose();
    _startCtrl.dispose();
    _endCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final provider = Provider.of<CourseProvider>(context, listen: false);

    try {
      if (widget.editingCourse == null) {
        await provider.addCourse(
          _nameCtrl.text.trim(),
          _codeCtrl.text.trim(),
          _day,
          _startCtrl.text.trim(),
          _endCtrl.text.trim(),
        );
      } else {
        await provider.updateCourse(
          widget.editingCourse!.id,
          _nameCtrl.text.trim(),
          _codeCtrl.text.trim(),
          _day,
          _startCtrl.text.trim(),
          _endCtrl.text.trim(),
        );
      }
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  InputDecoration field(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: c4.withOpacity(0.25),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.editingCourse != null;

    return Scaffold(
      backgroundColor: c5,
      appBar: AppBar(
        backgroundColor: c2,
        title: Text(editing ? "Edit Course" : "Add Course",
            style: const TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: field("Course name"),
                validator: (v) => v == null || v.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _codeCtrl,
                decoration: field("Course code"),
                validator: (v) => v == null || v.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField(
                value: _day,
                decoration: field("Day of week"),
                items: _days.map((d) {
                  return DropdownMenuItem(value: d, child: Text(d));
                }).toList(),
                onChanged: (v) => setState(() => _day = v!),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _startCtrl,
                decoration: field("Start time, example: 09:00"),
                validator: (v) => v == null || v.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _endCtrl,
                decoration: field("End time, example: 10:30"),
                validator: (v) => v == null || v.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 20),

              _isSaving
                  ? Center(child: CircularProgressIndicator(color: c2))
                  : SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: c2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: _save,
                        child: Text(editing ? "Save changes" : "Create course"),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
