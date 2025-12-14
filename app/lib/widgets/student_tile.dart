import 'package:flutter/material.dart';
import '../theme/colors.dart';

class StudentTile extends StatelessWidget {
  final String name;
  final int studentId;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final Widget? trailing;

  const StudentTile({
    super.key,
    required this.name,
    required this.studentId,
    this.onEdit,
    this.onDelete,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Card(
        color: c3,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          title: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: c1,
            ),
          ),
          subtitle: Text(
            "ID: $studentId",
            style: const TextStyle(color: c1),
          ),
          trailing: trailing ??
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (onEdit != null)
                    IconButton(
                      icon: const Icon(Icons.edit, color: c1),
                      onPressed: onEdit,
                    ),
                  if (onDelete != null)
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: onDelete,
                    ),
                ],
              ),
        ),
      ),
    );
  }
}
