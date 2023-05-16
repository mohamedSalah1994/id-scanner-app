import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../controllers/connectivity_provider.dart';

class InterNetWidget extends StatelessWidget {
  final Widget widget;
  const InterNetWidget({Key? key, required this.widget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConactivityProvider>(context, listen: true);
    return provider.connectionStatus == ConnectivityResult.none
        ? Scaffold(
            body: Center(
                child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/no-internet-connection.jpg'),
                  SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'تعذر الاتصال بالشبكه',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            )),
          )
        : widget;
  }
}
