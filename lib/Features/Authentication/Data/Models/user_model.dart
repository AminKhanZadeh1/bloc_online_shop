import 'package:bloc_online_shop/Features/Authentication/Domain/Entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String userId;
  final String email;
  final String name;

  const UserModel(
      {required this.userId, required this.email, required this.name});

  static const empty = UserModel(userId: '', email: '', name: '');

  UserModel copyWith({String? userId, String? email, String? name}) {
    return UserModel(
        userId: userId ?? this.userId,
        email: email ?? this.email,
        name: name ?? this.name);
  }

  UserEntity toEntity() {
    return UserEntity(userId: userId, email: email, name: name);
  }

  static UserModel fromEntity(UserEntity entity) {
    return UserModel(
        userId: entity.userId, email: entity.email, name: entity.name);
  }

  @override
  List<Object?> get props => [userId, email, name];
}
