// lib/widgets/routine_tile.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/routine.dart';
import '../providers/routine_provider.dart';
import '../screens/add_edit_routine_screen.dart';

class RoutineTile extends StatelessWidget {
  final Routine routine;
  const RoutineTile({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RoutineProvider>(context, listen: false);
    return Card(
      child: ListTile(
        title: Text(routine.name),
        subtitle: Text('${routine.day}, ${routine.startTime} - ${routine.endTime}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddEditRoutineScreen(editingRoutine: routine),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Delete routine'),
                    content: Text('Delete "${routine.name}"?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                      TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
                    ],
                  ),
                );
                if (confirmed == true) {
                  try {
                    await provider.deleteRoutine(routine.id);
                    if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Routine deleted')));
                  } catch (e) {
                    if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete failed: $e')));
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
