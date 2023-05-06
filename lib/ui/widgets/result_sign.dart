import 'package:flutter/cupertino.dart';

class ResultSign extends StatelessWidget {
  final IconData iconData;
  final String text;

  const ResultSign({
    super.key,
    required this.iconData,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, size: 100),
              const SizedBox(height: 10),
              Text(text,
                  style: const TextStyle(fontSize: 18), textAlign: TextAlign.center)
            ],
          ),
        ));
  }
}