// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:equatable/equatable.dart';

class User with EquatableMixin {
  String username;
  String email;
  String phoneNumber;
  String address;
  UserType userType;

  User({
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.userType,
  });

  User copyWith({
    String? username,
    String? email,
    String? phoneNumber,
    String? address,
    UserType? userType,
  }) {
    return User(
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      userType: userType ?? this.userType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      address: map['address'] as String,
      userType: userTypeID.keys
          .firstWhere((key) => userTypeID[key] == map['userType']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [username, email, phoneNumber, address, userType];
}

enum UserType {
  owner,
  worker,
}

Map<UserType, int> userTypeID = {
  UserType.owner: 0,
  UserType.worker: 1,
};
