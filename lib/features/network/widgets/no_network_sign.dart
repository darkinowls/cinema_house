import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/network_cubit.dart';

class NoNetworkSign extends StatelessWidget {
  final Widget elseChild;

  const NoNetworkSign({Key? key, required this.elseChild}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkCubit, NetworkState>(
        builder: (context, state) {
          if (state is NoNetwork) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off,
                  color: Theme
                      .of(context)
                      .focusColor,
                  size: 100,
                ),
                const SizedBox(height: 25),
                const Text("No internet connection"),
              ],
            );
          }
          return elseChild;
        }
    );
  }
}
