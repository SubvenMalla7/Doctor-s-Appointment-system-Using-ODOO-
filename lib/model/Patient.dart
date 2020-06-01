import 'package:flutter/material.dart';

class Patient with ChangeNotifier {
  final int id;
  final String name;
  final int age;
  final String gender;

  Patient(
   { @required this.id,
    @required this.name,
    @required this.age,
    @required this.gender}
  );
}
