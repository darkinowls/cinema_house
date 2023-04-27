import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/auth/cubit/auth_cubit.dart';
import '../../../../features/lightMode/widgets/light_mode_switch.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text("Notifications and sounds"),
                onTap: null,
              ),
              ListTile(
                leading: Icon(Icons.lock),
                title: Text("Privacy and security"),
                onTap: null,
              ),
            ],
          ),
        ),
        Container(
          height: 25,
          color: Colors.black12,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              ListTile(
                leading: Icon(Icons.language),
                title: Text("Switch language"),
                onTap: null,
              ),
              LightModeSwitch(),
            ],
          ),
        ),
        Container(
          height: 25,
          color: Colors.black12,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text("Logout"),
                onTap: () => BlocProvider.of<AuthCubit>(context).logout(),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
