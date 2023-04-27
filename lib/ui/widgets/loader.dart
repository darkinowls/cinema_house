import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Loading...", style: TextStyle(fontSize: 24)),
          SizedBox(height: 25),
          SizedBox(
            height: 60,
            width: 200,
            child: CircularProgressIndicator(
              // prebuilt animation
              strokeWidth: 8,
            ),
          ),
        ],
      ),
    );
  }
}
