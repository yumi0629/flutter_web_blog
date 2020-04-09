import 'package:flutter/material.dart';

class DefaultLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 180,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
        ),
      ),
    );
  }
}
