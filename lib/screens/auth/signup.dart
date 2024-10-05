import 'package:flutter/material.dart';
import 'package:furtime/utils/_screen_size.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

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
              'Signup Screen',
              style: TextStyle(fontSize: screen.width / 30),
            ),
          ),
        );
      },
    );
  }
}
