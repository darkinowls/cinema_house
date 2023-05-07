import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String phoneNumber;
  final int createdAt;
  final int updatedAt;

  UserModel(
      {required super.id,
      required super.name,
      required this.phoneNumber,
      required this.createdAt,
      required this.updatedAt});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
