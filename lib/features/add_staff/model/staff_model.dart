class StaffModel {
  final String id;
  final String fullname;
  final int staffNumber;
  final String password;

  StaffModel({required this.id, required this.fullname, required this.staffNumber, required this.password});

  factory StaffModel.fromMap(Map<String, dynamic> map) => StaffModel(
        id: map['id'],
        fullname: map['full_name'],
        staffNumber: map['staff_number'],
        password: map['password'],
      );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullname,
      'staff_number': staffNumber,
      'password': password,
    };
  }
}
