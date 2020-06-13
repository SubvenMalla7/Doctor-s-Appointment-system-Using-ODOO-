import 'package:appointment/model/Appointment.dart';
import 'package:appointment/model/Patient.dart';
import 'package:appointment/model/dataprovider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddAppointment extends StatefulWidget {
  static const routeName = '/addScreen';

  final List<String> data;
  final List<String> dataD;

  AddAppointment(this.data, this.dataD);

  @override
  _AddAppointmentState createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {
  final _form = GlobalKey<FormState>();
  var _isLoading = false;
  static DateTime dateTime = DateTime.now();
  var isInt = true;
  var selectedUnit = "Odoo Mates";
  var selectedUnitD = "Doctors";
  List<DropdownMenuItem<String>> _items;

  String date = DateFormat("yyyy-MM-dd").format(dateTime);

  var _addedAppointment =
      Appointment(appointmentId: null, patientId: '', doctorId: '', date: '');

  Future<void> _save(BuildContext context) async {
    // final isValid = _form.currentState.validate();
    // if (!isValid) {
    //   return;
    // }
    print("d1");
    _addedAppointment = Appointment(
        appointmentId: _addedAppointment.appointmentId,
        patientId: _addedAppointment.patientId,
        doctorId: _addedAppointment.doctorId,
        date: _addedAppointment.date);
    //_form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_addedAppointment.appointmentId == null) {
      print("d2");
      await Provider.of<Appointments>(context, listen: false)
          .addAppointment(_addedAppointment);
      print("done");
    } else {
      print("d3");
      try {
        // await Provider.of<Appointments>(context, listen: false)
        //     .addAppointment(_addedAppointment);
        // print("done");
      } catch (error) {
        print("d4");
        await showDialog(context: context, builder: (ctx) => AlertDialog()
            //alert(context, 'An Error Occurred', 'Please try again!'),
            );
      }
    }
    setState(() {
      _isLoading = false;
    });

    Navigator.of(context).pushNamed('/');
  }

  Widget dropDownP() {
    var _currentSelected = widget.data[0];
    return DropdownButton<String>(
      items: widget.data.map((selectedUnit) {
        return DropdownMenuItem<String>(
          value: selectedUnit,
          child: Text(
            selectedUnit,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        );
      }).toList(),
      onChanged: (String newValue) {
        var id = Provider.of<Appointments>(context).findByPName(newValue).id;
        _addedAppointment.patientId = id.toString();
        setState(() {
          selectedUnit = newValue;

          _addedAppointment.patientId = id.toString();
        });
        print("The $newValue is $id ${_addedAppointment.patientId}");
      },
      value: _currentSelected,
    );
  }

  Widget dropDownD() {
    var _currentSelectedD = widget.dataD[0];
    return DropdownButton<String>(
      items: widget.dataD.map((selectedUnit) {
        return DropdownMenuItem<String>(
          value: selectedUnit,
          child: Text(
            selectedUnit,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        );
      }).toList(),
      onChanged: (String newValue) {
        var idPatient =
            Provider.of<Appointments>(context).findByDName(newValue).id;
        _addedAppointment.doctorId = idPatient.toString();
        setState(() {
          selectedUnit = newValue;

          _addedAppointment.doctorId = idPatient.toString();
        });

        print("The $newValue is $idPatient ${_addedAppointment.doctorId}");
      },
      value: _currentSelectedD,
    );
  }

  Future<DateTime> selectdate(BuildContext context, DateTime dateTime) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: dateTime.subtract(new Duration(days: 3650)),
      lastDate: dateTime.add(new Duration(days: 3650)),
    );
    return picked;
  }

  void _selectdate(BuildContext context) {
    selectdate(context, dateTime).then((DateTime picked) {
      if (picked != null && picked != dateTime) {
        setState(
          () {
            dateTime = picked;
            _addedAppointment.date = DateFormat("yyyy-MM-dd").format(dateTime);
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Appointment"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pushReplacementNamed("/"),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Patient:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(alignment: Alignment.center, child: dropDownP()),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Doctor:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(alignment: Alignment.center, child: dropDownD()),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Appointment Date:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () => _selectdate(context),
                child: Text(
                  date,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Appointment set for Patient:$selectedUnit, Doctor:$selectedUnitD on $date",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          FlatButton(
            color: Theme.of(context).primaryColor,
            shape: StadiumBorder(),
            child: Text(
              'Set Appointment',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              _save(context);
              print(
                  "patient is ${_addedAppointment.patientId} and Doctor is ${_addedAppointment.doctorId}");
            },
          )
        ],
      ),
    );
  }
}
