import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './Appointment.dart';
import './Doctor.dart';
import './Patient.dart';

class Appointments extends ChangeNotifier {
  var id = '';
  var mainurl = 'http://192.168.0.107:8069';

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Cookie': 'session_id=cbacda570ced3c424243e688a9a5a0b49429b51a',
  };

  List<Appointment> itemsA = [];
  List<Patient> itemsP = [];
  List<Doctor> itemsD = [];
  Appointment findById(String id) {
    return itemsA.firstWhere((appoint) => appoint.appointmentId == id);
  }

  Patient findByPId(int id) {
    print(itemsP.firstWhere((med) => med.id == id).name);
    return itemsP.firstWhere((med) => med.id == id);
  }

  Patient findByPName(String name) {
    print(itemsP.firstWhere((med) => med.name == name).id);
    return itemsP.firstWhere((med) => med.name == name);
  }

  Doctor findByDId(int id) {
    print(itemsD.firstWhere((med) => med.id == id).name);
    return itemsD.firstWhere((med) => med.id == id);
  }

  Doctor findByDName(String name) {
    print(itemsD.firstWhere((med) => med.name == name).id);
    return itemsD.firstWhere((med) => med.name == name);
  }

  var parm = jsonEncode({"jsonrpc": "2.0", "params": {}});

  Future<void> addAppointment(Appointment appointment) async {
    print("d12");
    final url = '$mainurl/create_a';
    print(appointment.patientId);
    print(appointment.date);
    print(appointment.doctorId);
    final response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          "jsonrpc": "2.0",
          "params": {
            "patient_id": appointment.patientId,
            "appointment_date": appointment.date,
            "doctor_id": appointment.doctorId,
          }
        }));
    print("done");
    print(response.body);
    final newAppointment = Appointment(
      appointmentId: json.decode(response.body)['result']['id'].toString(),
      date: appointment.date,
      doctorId: appointment.doctorId,
      patientId: appointment.patientId,
    );

    itemsA.add(newAppointment);

    notifyListeners();
  }

  Future<void> auth() async {
    final url = '$mainurl/web/session/authenticate';

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
    // print(extractedData['result']['session_id']);
    id = extractedData['result']['session_id'];

    notifyListeners();
  }

  Future<void> fetchApointemnts() async {
    Uri url = Uri.parse('$mainurl/get_app');

    //  print('object');
    try {
      //print('object2');
      final response = await http.post(
        url,
        headers: headers,
        body: parm,
      );

      // print('object3');
      final extractedData = json.decode(response.body);
      // print('hello');
      // print(extractedData);

      final List<Appointment> loadedAppointment = [];

      extractedData['result'].forEach((appointmentData) {
        var patientidFinal;
        var doctoridFinal;
        var docFinal;
        var rawPatientid = appointmentData['patient'];
        var rawDoctorid = appointmentData['doctor'];
        //print(rawPatientid);
        print(rawDoctorid);

        var splt = rawPatientid.split('(');
        var spltD = rawDoctorid.split('(');
        // print(splt[1]);
        print(spltD[1]);
        var length = splt[1].length - 2;
        var lengthD = spltD[1].length - 2;
        if (length == 3 || lengthD == 3) {
          patientidFinal = splt[1].substring(0, 3);
          doctoridFinal = spltD[1].substring(0, 3);
          //  print("Final string is $patientidFinal");
          print("Final 3stringD is $doctoridFinal");
        } else if (length == 2 || lengthD == 2) {
          patientidFinal = splt[1].substring(0, 2);
          doctoridFinal = spltD[1].substring(0, 2);
          // print("Final string is $patientidFinal");
          print("Final 2stringD is $doctoridFinal");
        } else if (length == 1 || lengthD == 1) {
          patientidFinal = splt[1].substring(0, 1);
          doctoridFinal = spltD[1].substring(0, 1);
          print("Final 1stringD is $doctoridFinal");
        } else {
          // print("Sorry invalid patientID");
        }
        if (doctoridFinal.contains(',')) {
          print(doctoridFinal.replaceAll(new RegExp(','), ''));
          docFinal = doctoridFinal.replaceAll(new RegExp(','), '');
        } else {
          docFinal = doctoridFinal;
        }
        print("doctoir");
        print(doctoridFinal);
        loadedAppointment.add(
          Appointment(
              appointmentId: appointmentData['sequence'],
              date: appointmentData['date'],
              doctorId: docFinal,
              patientId: patientidFinal),
        );
      });
      //print(loadedAppointment);

      itemsA = loadedAppointment;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchPatient() async {
    Uri url = Uri.parse('$mainurl/get_patients');

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
    Uri url = Uri.parse('$mainurl/get_doctors');

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
            id: doctorData['id'],
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
