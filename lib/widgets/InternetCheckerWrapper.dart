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
            //none = no connection
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
                // emplement callbacke after finesh the current frame ,so it may cause error
                setState(() {
                  isOffline = false;
                });
              });
            }
          }
        }
        if (isOffline) {
          return Stack(
            children: [
              widget.child,
              Positioned(
                top: 2,
                left: 2,
                right: 2,
                child: Material(
                  color: const Color.fromARGB(186, 108, 107, 107),
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 15),
                        SizedBox(width: 10),
                        Text(
                          'no internet connection.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
