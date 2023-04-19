import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:students/Services/global.dart';

class AuthServices {
  static Future<http.Response> login(String email, String password) async {
    Map data = {
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'auth/login');
    http.Response response = await http.post(url, headers: headers, body: body);

    return response;
  }

  static Future<http.Response> details() async {
    var token = "";
    var url = Uri.parse(baseURL + 'auth/details');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    print(response.body);
    return response;
  }

  static Future<http.Response> logout() async {
    var token = "";
    var url = Uri.parse(baseURL + 'auth/logout');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    return response;
  }

  static Future<http.Response> getSeats() async {
    var token = "";
    var url = Uri.parse(baseURL + 'section/seats');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    print(response.body);
    return response;
  }

  static Future<http.Response> getSeatInfo(seat, is_home) async {
    var token = "";
    var url = Uri.parse(
        baseURL + 'section/seat?seat=' + seat + '&in_home=' + is_home);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.body);
    return response;
  }

  static Future<http.Response> useSeat(String seat) async {
    var token = "";
    Map data = {
      "seat": seat,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'section/seat');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    http.Response response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body);
    print(response.body);
    return response;
  }

  static Future<http.Response> myLogs() async {
    var token = "";
    var url = Uri.parse(baseURL + 'section/myLogs');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.body);
    return response;
  }
}
