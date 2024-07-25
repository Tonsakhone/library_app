import 'package:cloud_firestore/cloud_firestore.dart';

class RentBookModel {
  final String id;
  final String studentId;
  final String barCode;
  final DateTime rentAt;
  final DateTime returnAt;

  RentBookModel({required this.id, required this.studentId, required this.barCode, required this.rentAt, required this.returnAt});

  factory RentBookModel.fromMap(Map<String, dynamic> map) {
    return RentBookModel(
      id: map['id'],
      studentId: map['student_id'],
      barCode: map['book_barCode'],
      rentAt: (map['rent_date'] as Timestamp).toDate(),
      returnAt: (map['return_date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'student_id': studentId,
      'book_barCode': barCode,
      'rent_date': rentAt,
      'return_date': returnAt,
    };
  }
}
