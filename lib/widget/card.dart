// import 'package:flutter/material.dart';

// class Card extends StatelessWidget {
 

//   @override
//   Widget build(BuildContext context) {
//      final screenSize = MediaQuery.of(context).size;
//     return Container(
//       child:Column(
//       children: <Widget>[
//         Container(
//           height: screenSize.height * 0.17,
//           width: screenSize.width * 0.88,
//           decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: widget.color,
//                   spreadRadius: 2,
//                   blurRadius: 10,
//                   offset: Offset(0, 0),
//                 )
//               ],
//               color: widget.color,
//               borderRadius: BorderRadius.all(Radius.circular(20))),
//           child: Column(
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   CircleAvatar(
//                     maxRadius: 30,
//                     child: Icon(Icons.calendar_today),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 16.0),
//                     child: Column(
//                       children: <Widget>[
//                         Text(
//                           widget.appoinmentId,
//                           style: textStyle(),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           patientName,
//                           style: textStyle(),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         top: 20, left: 10, bottom: 10, right: 0),
//                     child: CircleAvatar(
//                       maxRadius: 30,
//                       child: Icon(Icons.account_circle),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   Text(
//                     widget.date,
//                     style: textStyle(),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Text(
//                     doctorName,
//                     style: textStyle(),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//       ],
//     );,
//     );
//   }
// }
