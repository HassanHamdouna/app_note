import 'package:flutter/material.dart';

class AppCircularProgress extends StatelessWidget {
  const AppCircularProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.lightBlue,
        backgroundColor: Colors.black26,
      ),
    );
  }
}
