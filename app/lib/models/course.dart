import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final String id;
  final String name;
  final String code;

  Course({
    required this.id,
    required this.name,
    required this.code,
  });

  factory Course.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return Course(
      id: doc.id,
      name: data['name'] ?? '',
      code: data['code'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
    };
  }
}

