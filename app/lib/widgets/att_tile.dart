import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../theme/colors.dart';

class AttendanceTile extends StatelessWidget {
  final QueryDocumentSnapshot doc;

  const AttendanceTile({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    final date = (doc['date'] as Timestamp).toDate();
    final records = Map<String, dynamic>.from(doc['records']);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: c3,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${date.day}-${date.month}-${date.year}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),

          ...records.entries.map(
            (e) => Text(
              "Student ${e.key}: ${e.value}",
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
