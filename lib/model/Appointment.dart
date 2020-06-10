import 'package:flutter/material.dart';

class Appointment with ChangeNotifier {
  final String appointmentId;
  final String patientId;
  final String doctorId;
  final String date;

  Appointment({
    @required this.appointmentId,
    @required this.patientId,
    @required this.doctorId,
    @required this.date,
  });
}
