import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dio_client.dart';
import '../../../../core/locale_keys.g.dart';
import '../../../../core/locator.dart';
import '../../../../features/auth/cubit/auth_cubit.dart';
import '../../../../features/lang/cubit/lang_state.dart';
import '../../../../features/lightMode/widgets/light_mode_switch.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.settings.tr()),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.notifications),
                title: Text(LocaleKeys.notificationsAndSounds.tr()),
                onTap: null,
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                title: Text(LocaleKeys.privacyAndSecurity.tr()),
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
            children: [
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(LocaleKeys.switchLanguage.tr()),
                onTap: () {
                  final LangStatus langStatus =
                  LangStatus.switchLang(context.locale.languageCode);
                  context.setLocale(Locale(langStatus.lang));
                  locator<DioClient>().dio.options.headers = {
                        "Accept-Language": langStatus.lang
                  };
                },
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
                title: Text(LocaleKeys.logout.tr()),
                onTap: () => BlocProvider.of<AuthCubit>(context).logout(),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
