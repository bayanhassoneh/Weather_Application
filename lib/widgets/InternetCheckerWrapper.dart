import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class Internetcheckerwrapper extends StatefulWidget {
  final Widget child;
  Internetcheckerwrapper({super.key, required this.child});
  @override
  State<Internetcheckerwrapper> createState() => _Internetcheckerstate();
}

class _Internetcheckerstate extends State<Internetcheckerwrapper> {
  bool isOffline = false;
  Timer? _debounceTimer;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        final connectivityResult = snapshot.data;

        if (connectivityResult != null) {
          if (connectivityResult.contains(ConnectivityResult.none)) {
            if (_debounceTimer == null || !_debounceTimer!.isActive) {
              _debounceTimer = Timer(const Duration(seconds: 3), () {
                setState(() {
                  isOffline = true;
                });
              });
            }
          } else {
            _debounceTimer?.cancel();
            if (isOffline) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  isOffline = false;
                });
              });
            }
          }
        }
        if (isOffline) {
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  Icon(Icons.signal_wifi_off, size: 80, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    'No Internet Connection',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Please check your network settings.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        }
        return widget.child;
      },
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
