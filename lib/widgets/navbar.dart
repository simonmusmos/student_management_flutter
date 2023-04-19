import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:students/Screens/login_screen.dart';
import 'package:students/Screens/main_screen.dart';
import 'package:students/Screens/my_logs.dart';
import 'package:students/Services/auth_services.dart';
import 'package:http/http.dart' as http;

class navbar extends StatefulWidget {
  const navbar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<navbar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(''),
          ),
          ListTile(
            leading: Icon(
              Icons.meeting_room,
            ),
            title: const Text('My Section',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const main_screen(),
                    // builder: (BuildContext context) => const QRViewExample(),
                  ));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.notes,
            ),
            title: const Text('My Logs',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const my_logs(),
                    // builder: (BuildContext context) => const QRViewExample(),
                  ));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
            ),
            title: const Text('Logout',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              logout();
            },
          ),
        ],
      ),
    );
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response response = await AuthServices.logout();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(),
          // builder: (BuildContext context) => const QRViewExample(),
        ));
  }
}
