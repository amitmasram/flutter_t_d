
import 'package:json_annotation/json_annotation.dart';

part 'usermodel.g.dart';
@JsonSerializable()
class UsersModel {
  final String id;
  final String name;
  final String email;

  UsersModel({required this.id, required this.name, required this.email});

  factory UsersModel.fromJson(Map<String, dynamic> json) =>
      _$UsersModelFromJson(json);
  Map<String, dynamic> toJson() => _$UsersModelToJson(this);
}
