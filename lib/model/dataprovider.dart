import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_api_connector.dart';
import 'package:odoo_api/odoo_user_response.dart';

import './Appointment.dart';
import './Doctor.dart';
import './Patient.dart';

class Appointments extends ChangeNotifier {
  var id = '';

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Cookie': 'session_id=69cec0086cd1ee0177416234bca200cf458e9b18',
  };

  List<Appointment> itemsA = [];
  List<Patient> itemsP = [];
  List<Doctor> itemsD = [];
  Appointment findById(int id) {
    return itemsA.firstWhere((appoint) => appoint.appointmentId == id);
  }

  var parm = jsonEncode({"jsonrpc": "2.0", "params": {}});

  Future<void> addAppointment() async {
    final url =
        'http://192.168.56.102:8069/create_a?api_token=84f91eac23a702674cb5756dcd8a32c9bb45107f';

    final response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          "jsonrpc": "2.0",
          "params": {
            "patient_id": "044",
            "appointment_date": "2055/02/01",
            "doctor_id": "1",
          }
        }));
    print(response.body);
    // final newAppointment = Appointment(
    //   appointmentId: json.decode(response.body)['data']['id'],
    //   date: appointment.date,
    //   doctorId: appointment.doctorId,
    //   patientId: appointment.patientId,
    // );

    // items.add(newAppointment);

    notifyListeners();
  }

  Future<void> auth() async {
    final url = 'http://192.168.56.102:8069/web/session/authenticate';

    final response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          "jsonrpc": "2.0",
          "params": {
            "db": "office",
            "login": "odoo@odoo.com",
            "password": "123456789"
          }
        }));

    //print(response.body);
    final extractedData = json.decode(response.body);
    print(extractedData['result']['session_id']);
    id = extractedData['result']['session_id'];

    // final newAppointment = Appointment(
    //   appointmentId: json.decode(response.body)['data']['id'],
    //   date: appointment.date,
    //   doctorId: appointment.doctorId,
    //   patientId: appointment.patientId,
    // );

    // items.add(newAppointment);

    notifyListeners();
  }

  Future<void> fetchApointemnts() async {
    Uri url = Uri.parse('http://192.168.56.102:8069/get_app');

    print('object');
    try {
      print('object2');
      final response = await http.post(
        url,
        headers: headers,
        body: parm,
      );
      print('object3');
      final extractedData = json.decode(response.body);
      print('hello');
      print(extractedData);

      final List<Appointment> loadedAppointment = [];

      extractedData['result'].forEach((appointmentData) {
        print(appointmentData['sequence']);

        loadedAppointment.add(
          Appointment(
              appointmentId: appointmentData['sequence'],
              date: appointmentData['date'],
              doctorId: appointmentData['doctor_id'],
              patientId: appointmentData['patient_id']),
        );
      });
      print(loadedAppointment);

      itemsA = loadedAppointment;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchPatient() async {
    Uri url = Uri.parse('http://192.168.56.102:8069/get_patients');

    print('object');
    try {
      print('object2');
      final response = await http.post(
        url,
        headers: headers,
        body: parm,
      );
      print('object3');
      final extractedData = json.decode(response.body);
      print('hello');
      print(extractedData['result']['response']);

      final List<Patient> loadedPatients = [];

      extractedData['result']['response'].forEach((patientData) {
        print(patientData['id']);

        loadedPatients.add(
          Patient(
            id: patientData['id'],
            name: patientData['name'],
            age: patientData['age'],
            gender: patientData['gender'],
          ),
        );
      });
      //print(loadedPatients);

      itemsP = loadedPatients;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchDoctor() async {
    Uri url = Uri.parse('http://192.168.56.102:8069/get_doctors');

    print('object');
    try {
      print('object2');
      final response = await http.post(
        url,
        headers: headers,
        body: parm,
      );
      print('object3');
      final extractedData = json.decode(response.body);
      print('hello');
      print(extractedData['result']);

      final List<Doctor> loadedDoctors = [];

      extractedData['result']['response'].forEach((doctorData) {
        //print(patientData['id']);

        loadedDoctors.add(
          Doctor(
            name: doctorData['name'],
            gender: doctorData['gender'],
          ),
        );
      });
      //print(loadedDoctors);

      itemsD = loadedDoctors;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
