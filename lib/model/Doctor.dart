import 'package:flutter/material.dart';

class Doctor with ChangeNotifier{
  final int id;
  final String name;
  final String gender;

  Doctor({
    @required this.id,
    @required this.gender,
    @required this.name,
  });
}
