class MemberModel {
  final String id;
  final String name;
  final String gender;
  final String major;
  final String studentId;
  final String phoneNumber;
  final DateTime createAt;

  MemberModel(
      {required this.id,
      required this.name,
      required this.gender,
      required this.major,
      required this.studentId,
      required this.phoneNumber,
      required this.createAt});

  factory MemberModel.fromMap(Map<String, dynamic> map) {
    return MemberModel(
      id: map['member_id'],
      name: map['member_name'],
      gender: map['member_gender'],
      major: map['member_major'],
      studentId: map['std_id'],
      phoneNumber: map['phone_number'],
      createAt: map['create_at']?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'member_id': id,
      'member_name': name,
      'member_gender': gender,
      'member_major': major,
      'std_id': studentId,
      'phone_number': phoneNumber,
      'create_at': createAt,
    };
  }
}
