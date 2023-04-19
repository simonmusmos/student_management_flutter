import 'dart:developer';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:students/Services/auth_services.dart';
import 'package:students/widgets/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/global.dart';

class my_logs extends StatefulWidget {
  const my_logs({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LogScreenState createState() => _LogScreenState();
}

class _LogScreenState extends State<my_logs> {
  List<Map> dataList = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
          ),
          drawer: navbar(),
          body: SafeArea(
              child: Center(
                  child: Column(
            // ignore: prefer_const_constructors
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                'My Logs',
                style: TextStyle(fontSize: 21, fontFamily: 'BebasNeue'),
                // style: GoogleFonts.bebasNeue(
                //   fontSize: 54,
                // ),
              ),
              SizedBox(height: 50),
              DataTable(
                columns: [
                  DataColumn(
                      label: Text(
                    'Row',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600]),
                  )),
                  DataColumn(
                      label: Text(
                    'Seat Number',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600]),
                  )),
                  DataColumn(
                      label: Text(
                    'Date',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600]),
                  ))
                ],
                rows:
                    dataList // Loops through dataColumnText, each iteration assigning the value to element
                        .map(
                          ((element) => DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(
                                    element["row"],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )), //Extracting from Map element the value
                                  DataCell(Text(element["seat_no"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                                  DataCell(Text(element["date"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                                ],
                              )),
                        )
                        .toList(),
              )
            ],
          ))),
        ),
        if (_isLoading)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  MyLogs() async {
    setState(() {
      _isLoading = true;
    });

    http.Response response = await AuthServices.myLogs();

    setState(() {
      dataList = new List<Map>.from(jsonDecode(response.body)['message']);
      // dataList = jsonDecode(response.body)['message'];
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print(123);
      MyLogs();
      // UpdateSeats();
    });
  }
}
