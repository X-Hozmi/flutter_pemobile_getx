import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final int id;
  final String? name;
  final String? email;
  final String? handphone;
  final String? address;
  final String? password;

  const Person({
    required this.id,
    required this.name,
    required this.email,
    required this.handphone,
    required this.address,
    required this.password,
  });

  @override
  List<Object?> get props => [id, name, email, handphone, address, password];
}
