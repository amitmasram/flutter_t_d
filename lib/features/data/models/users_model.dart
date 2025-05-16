import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'users_model.g.dart';

@HiveType(typeId: 0) // Use a unique typeId for this class
@JsonSerializable()
class UsersModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  bool isSelected;

  UsersModel({
    required this.id,
    required this.name,
    required this.email,
    this.isSelected = false,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) =>
      _$UsersModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersModelToJson(this);
}
