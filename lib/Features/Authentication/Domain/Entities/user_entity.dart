import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String email;
  final String name;

  const UserEntity(
      {required this.userId, required this.email, required this.name});

  Map<String, dynamic> get toDocument =>
      {'userId': userId, 'email': email, 'name': name};

  static UserEntity fromDocument(Map<String, dynamic> doc) {
    return UserEntity(
        userId: doc['userId'], email: doc['email'], name: doc['name']);
  }

  @override
  List<Object?> get props => [userId, email, name];
}
