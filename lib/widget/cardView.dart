import 'package:appointment/model/dataprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardView extends StatefulWidget {
  final String appoinmentId;
  final String appoPatientId;
  final String appoDoctorId;
  final String date;
  final Color color;


  const CardView(this.appoinmentId, this.appoPatientId, this.appoDoctorId,
      this.color, this.date);

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  var patientName = "";
  var doctorName = '';

  var isload = true;
  TextStyle textStyle() {
    return TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isload) {
      print(widget.appoDoctorId);
      checkId(context, widget.appoPatientId);
      checkDId(context, widget.appoDoctorId);
      isload = false;
    }
  }

  void checkId(BuildContext context, String id) {
    final patientData = Provider.of<Appointments>(context)
        .findByPId(int.parse(widget.appoPatientId));
    print(patientData.name);

    setState(() {
      patientName = patientData.name;
    });
  }

  void checkDId(BuildContext context, String id) {
    final doctorData =
        Provider.of<Appointments>(context).findByDId(int.parse(id));
    print(doctorData.name);
    setState(() {
      doctorName = doctorData.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final patientData = Provider.of<Patient>(context);
    final screenSize = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Container(
          height: screenSize.height * 0.17,
          width: screenSize.width * 0.88,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: widget.color,
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 0),
                )
              ],
              color: widget.color,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CircleAvatar(
                    maxRadius: 30,
                    child: Icon(Icons.calendar_today),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          widget.appoinmentId,
                          style: textStyle(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          patientName,
                          style: textStyle(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 10, bottom: 10, right: 0),
                    child: CircleAvatar(
                      maxRadius: 30,
                      child: Icon(Icons.account_circle),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    widget.date,
                    style: textStyle(),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    doctorName,
                    style: textStyle(),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
