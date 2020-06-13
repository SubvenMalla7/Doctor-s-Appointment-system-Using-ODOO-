import 'package:appointment/widget/cardView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/dataprovider.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  bool isInt = true;

  @override
  void didChangeDependencies() {
    dataFetch();
    super.didChangeDependencies();
  }

  dataFetch() {
    if (isInt) {
      final data = Provider.of<Appointments>(context).fetchApointemnts();
      final dataPatient = Provider.of<Appointments>(context).fetchPatient();
      final dataDoctors = Provider.of<Appointments>(context).fetchDoctor();
      print(data);
      print(dataPatient);
      print(dataDoctors);

      isInt = false;
    }
  }

  Future<void> refresh() {
    return Provider.of<Appointments>(context).fetchApointemnts();
  }

  @override
  Widget build(BuildContext context) {
    final appointment = Provider.of<Appointments>(context);
     return RefreshIndicator(
      onRefresh: refresh,
      child: Container(
        child: Container(
          padding: const EdgeInsets.only(top: 40),
          child: ListView.builder(
            itemBuilder: (context, index) => CardView(
                appointment.itemsA[index].appointmentId,
                appointment.itemsA[index].patientId,
                appointment.itemsA[index].doctorId,
                
                appointment.itemsA[index].date),
            itemCount: appointment.itemsA.length,
          ),
        ),
      ),
    );
  }
}
