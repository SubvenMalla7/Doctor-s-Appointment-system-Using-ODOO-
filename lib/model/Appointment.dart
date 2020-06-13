import 'package:flutter/material.dart';

class Appointment with ChangeNotifier {
  final String appointmentId;
  String patientId;
  String doctorId;
  String date;

  Appointment({
    @required this.appointmentId,
    @required this.patientId,
    @required this.doctorId,
    @required this.date,
  });
}
