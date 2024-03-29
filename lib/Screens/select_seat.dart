import 'dart:developer';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:students/Screens/main_screen.dart';
import 'package:students/Screens/select_seat.dart';

import 'package:students/Services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/global.dart';
import 'login_screen copy.dart';

// void main() => runApp(const MaterialApp(home: MyHome()));

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SelectSeat(),
            ));
          },
          child: const Text('qrView'),
        ),
      ),
    );
  }
}

class SelectSeat extends StatefulWidget {
  const SelectSeat({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectSeatState();
}

class _SelectSeatState extends State<SelectSeat> {
  int ctr = 0;
  bool _isLoading = true;
  List seat_list = [];
  List occupied = [];
  String selected_seat = "";
  String selected_row = "";
  String owner_info = "";
  String _selected = "";
  String _selected_seat = "";
  Color button_color = Colors.black;
  Color seat_color = Colors.green;
  Widget build(BuildContext context) {
    ctr = 0;
    if (_selected_seat == "") {
      button_color = Colors.black26;
    } else {
      button_color = Colors.black;
    }
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.grey[300],
          body: SafeArea(
              child: Center(
                  child: Column(
            // ignore: prefer_const_constructors
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                'Hello! Please select a seat to continue.',
                style: TextStyle(fontSize: 21, fontFamily: 'BebasNeue'),
                // style: GoogleFonts.bebasNeue(
                //   fontSize: 54,
                // ),
              ),
              SizedBox(height: 50),
              ...List.generate(6, (row) {
                return Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: List.generate(10, (col) {
                    ctr += 1;
                    String _seat = "";
                    if (col < 5) {
                      _seat = "a-" +
                          (row + 1).toString() +
                          "-" +
                          (col + 1).toString();
                    } else {
                      _seat = "b-" +
                          (row + 1).toString() +
                          "-" +
                          ((col + 1) - 5).toString();
                    }
                    if (seat_list.contains(_seat)) {
                      if (_selected == _seat) {
                        return Padding(
                          padding: const EdgeInsets.all(3),
                          child: InkWell(
                            onTap: () {
                              String seat = "";
                              if (col < 5) {
                                seat = "a-" +
                                    (row + 1).toString() +
                                    "-" +
                                    (col + 1).toString();
                              } else {
                                seat = "b-" +
                                    (row + 1).toString() +
                                    "-" +
                                    ((col + 1) - 5).toString();
                              }
                              UpdateSeats();
                              CheckSeat(seat);
                              setState(() {
                                _selected = seat;
                                selected_row = "Row: " + (row + 1).toString();
                                selected_seat =
                                    "Seat Number: " + (col + 1).toString();
                              });
                            }, // Handle your callback
                            child: Ink(
                              height: 30,
                              width: 30,
                              color: Colors.blue,
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(3),
                          child: InkWell(
                            onTap: () {
                              String seat = "";
                              if (col < 5) {
                                seat = "a-" +
                                    (row + 1).toString() +
                                    "-" +
                                    (col + 1).toString();
                              } else {
                                seat = "b-" +
                                    (row + 1).toString() +
                                    "-" +
                                    ((col + 1) - 5).toString();
                              }
                              UpdateSeats();
                              CheckSeat(seat);
                              setState(() {
                                _selected = seat;
                                selected_row = "Row: " + (row + 1).toString();
                                selected_seat =
                                    "Seat Number: " + (col + 1).toString();
                              });
                            }, // Handle your callback
                            child: Ink(
                              height: 30,
                              width: 30,
                              color: Colors.green,
                            ),
                          ),
                        );
                      }
                    } else if (occupied.contains(_seat)) {
                      return Padding(
                        padding: const EdgeInsets.all(3),
                        child: InkWell(
                          onTap: () {
                            String seat = "";
                            if (col < 5) {
                              seat = "a-" +
                                  (row + 1).toString() +
                                  "-" +
                                  (col + 1).toString();
                            } else {
                              seat = "b-" +
                                  (row + 1).toString() +
                                  "-" +
                                  ((col + 1) - 5).toString();
                            }
                            CheckSeat(seat);
                            setState(() {
                              _selected = seat;
                              selected_row = "Row: " + (row + 1).toString();
                              selected_seat =
                                  "Seat Number: " + (col + 1).toString();
                            });
                          }, // Handle your callback
                          child: Ink(
                            height: 30,
                            width: 30,
                            color: Colors.red,
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(3),
                        child: InkWell(
                          onTap: () {}, // Handle your callback
                          child: Ink(
                            height: 30,
                            width: 30,
                            color: Colors.grey[300],
                          ),
                        ),
                      );
                    }
                  }),
                );
              }),
              SizedBox(height: 20),
              Text(
                selected_row,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                selected_seat,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                owner_info,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: SizedBox(
                    width: double.infinity, // <-- match_parent
                    height: 50,
                    child: ElevatedButton(
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          color: Color.fromARGB(255, 250, 250, 250),
                          fontSize: 27,
                          fontFamily: 'BebasNeue',
                        ),
                      ),
                      onPressed: () => UseSeat(_selected_seat),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          backgroundColor: button_color,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                  ))
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

  SeatPressed() async {
    setState(() {
      _isLoading = true;
    });

    setState(() {
      _isLoading = false;
    });
  }

  UpdateSeats() async {
    setState(() {
      _isLoading = true;
    });

    http.Response response = await AuthServices.getSeats();
    List responseMap = jsonDecode(response.body)['seats'];
    List occupiedMap = jsonDecode(response.body)['occupied'];
    setState(() {
      _isLoading = false;
      seat_list = responseMap;
      occupied = occupiedMap;
    });
  }

  CheckSeat(seat) async {
    setState(() {
      _isLoading = true;
    });

    http.Response response = await AuthServices.getSeatInfo(seat, '0');
    bool status = jsonDecode(response.body)['status'];
    setState(() {
      if (jsonDecode(response.body)['status'] == true) {
        _selected_seat = seat;
        owner_info = "";
      } else {
        _selected_seat = "";
        owner_info = "Owner: " + jsonDecode(response.body)['owner'];
      }

      _isLoading = false;
    });
  }

  UseSeat(seat) async {
    if (seat != "") {
      setState(() {
        _isLoading = true;
      });

      http.Response response = await AuthServices.useSeat(seat);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => main_screen(),
            // builder: (BuildContext context) => const QRViewExample(),
          ));
      setState(() {
        _isLoading = false;
        // button_status = jsonDecode(response.body)['status'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      UpdateSeats();
    });
  }
}
