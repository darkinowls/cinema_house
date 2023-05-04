import 'package:cinema_house/core/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text( LocaleKeys.loading.tr(), style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 25),
          const SizedBox(
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
