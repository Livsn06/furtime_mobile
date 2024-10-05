import 'package:flutter/material.dart';
import 'package:furtime/utils/_screen_size.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  double screen = 0;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var screen = Screen.constraints(constraints);

        //
        return Scaffold(
          body: Center(
            child: Text(
              'Login Screen',
              style: TextStyle(fontSize: screen.width / 30),
            ),
          ),
        );
      },
    );
  }
}
