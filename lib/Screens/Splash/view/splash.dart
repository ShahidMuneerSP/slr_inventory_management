// ignore_for_file: use_build_context_synchronously, strict_top_level_inference

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slr_inventory_management/Screens/Dashboard/view/dashboard_view.dart';
import 'package:slr_inventory_management/Screens/Intro/view/intro_view.dart';
import 'package:slr_inventory_management/Screens/Login/view/login_view.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogged = true;
  String token = '';

  @override
  void initState() {
    super.initState();
    _isLogged();

   
    Timer(Duration(milliseconds: 500), () async {
      final status = await Permission.location.request();
      if (status.isGranted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => (isLogged == true)
                    ? IntroSplash()
                    : token == ''
                        ? LoginScreen()
                        : DashboardScreen()));
      } else {
        _requestLocationPermission(context);
      }
    });
  }

  _isLogged() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    isLogged = pref.getBool('islogged')!;
    log("${pref.get('islogged')} Is Logged");

    token = pref.getString('token')!;
    if (token != '') {
      FlutterBackgroundService().invoke('setAsBackground');
    }
  }

  void _requestLocationPermission(BuildContext context) async {
   
    final userConsent = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Location Access Required'),
          content: Text(
            'This app collects location data to enable navigation services even when the app is closed or not in use. '
            'This data is used to improve the user experience and may be shared with third-party services.',
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(false), // User denies consent
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(true), // User grants consent
              child: Text('Allow'),
            ),
          ],
        );
      },
    );

    // If user consented, request runtime permission
    if (userConsent == true) {
      final status = await Permission.location.request();

      if (status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permission granted!')),
        );
        // Proceed with accessing location data
      } else if (status.isDenied || status.isPermanentlyDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permission denied.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User did not consent to location access.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/Images/slr_logo.png',
          height: 150,
        ),
      ),
    );
  }
}
