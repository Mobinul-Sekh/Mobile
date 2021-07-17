import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.not_accessible_rounded,
              size: 100,
            ),
            const SizedBox(height: 12),
            Text("404: Page Not Found"),
          ],
        ),
      ),
    );
  }
}
