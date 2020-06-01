import 'package:flutter/material.dart';

class Doctor with ChangeNotifier{
  
  final String name;
  final String gender;

  Doctor({
    @required this.gender,
    @required this.name,
  });
}
