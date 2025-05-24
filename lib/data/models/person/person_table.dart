import 'package:equatable/equatable.dart';
import 'package:flutter_pemobile_getx/domain/entities/person/person.dart';

class PersonTable extends Equatable {
  final int id;
  final String? name;
  final String? email;
  final String? handphone;
  final String? address;
  final String? password;

  const PersonTable({
    required this.id,
    required this.name,
    required this.email,
    required this.handphone,
    required this.address,
    required this.password,
  });

  factory PersonTable.fromEntity(Person person) {
    return PersonTable(
      id: person.id,
      name: person.name,
      address: person.address,
      email: person.email,
      handphone: person.handphone,
      password: person.password,
    );
  }

  factory PersonTable.fromMap(Map<String, dynamic> map) {
    return PersonTable(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      email: map['email'],
      handphone: map['handphone'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'email': email,
      'handphone': handphone,
      'password': password,
    };
  }

  Person toEntity() {
    return Person(
      id: id,
      name: name,
      address: address,
      email: email,
      handphone: handphone,
      password: password,
    );
  }

  @override
  List<Object?> get props => [id, name, address, email, handphone, password];
}
