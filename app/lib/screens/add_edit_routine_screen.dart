// lib/screens/add_edit_routine_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/routine.dart';
import '../providers/routine_provider.dart';

class AddEditRoutineScreen extends StatefulWidget {
  final Routine? editingRoutine;
  final String? courseId; // required when creating

  const AddEditRoutineScreen({super.key, this.editingRoutine, this.courseId});

  @override
  State<AddEditRoutineScreen> createState() => _AddEditRoutineScreenState();
}

class _AddEditRoutineScreenState extends State<AddEditRoutineScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _startCtrl = TextEditingController();
  final _endCtrl = TextEditingController();
  String _day = 'Monday';
  bool _saving = false;

  final _days = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];

  @override
  void initState() {
    super.initState();
    if (widget.editingRoutine != null) {
      final r = widget.editingRoutine!;
      _nameCtrl.text = r.name;
      _day = r.day;
      _startCtrl.text = r.startTime;
      _endCtrl.text = r.endTime;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _startCtrl.dispose();
    _endCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final provider = Provider.of<RoutineProvider>(context, listen: false);
    final routine = Routine(
      id: widget.editingRoutine?.id ?? '',
      name: _nameCtrl.text.trim(),
      day: _day,
      startTime: _startCtrl.text.trim(),
      endTime: _endCtrl.text.trim(),
      courseId: widget.editingRoutine?.courseId ?? widget.courseId ?? '',
    );
    try {
      if (widget.editingRoutine == null) {
        await provider.addRoutine(routine);
      } else {
        await provider.updateRoutine(routine.id, routine);
      }
      if (mounted) Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.editingRoutine != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Routine' : 'Add Routine')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Routine title'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Enter title' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _day,
                items: _days.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                onChanged: (v) { if (v != null) setState(() => _day = v); },
                decoration: const InputDecoration(labelText: 'Day'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _startCtrl,
                decoration: const InputDecoration(labelText: 'Start time, e.g. 09:00'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Enter start time' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _endCtrl,
                decoration: const InputDecoration(labelText: 'End time, e.g. 10:30'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Enter end time' : null,
              ),
              const SizedBox(height: 20),
              _saving
                  ? const CircularProgressIndicator()
                  : ElevatedButton(onPressed: _save, child: Text(isEditing ? 'Save' : 'Create')),
            ],
          ),
        ),
      ),
    );
  }
}
