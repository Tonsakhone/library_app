class BookModel {
  final String id;
  final String name;
  final String? image;
  final String barCode;

  BookModel({required this.id, required this.name, required this.image, required this.barCode});

  factory BookModel.fromMap(Map<String, dynamic> map) => BookModel(
        id: map['id'],
        name: map['name'],
        image: map['image'] as String?,
        barCode: map['barCode'],
      );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'barCode': barCode,
    };
  }
}
