import 'package:cinema_house/core/codegen_loader.g.dart';
import 'package:cinema_house/features/auth/cubit/auth_cubit.dart';
import 'package:cinema_house/features/lightMode/cubit/light_mode_cubit.dart';
import 'package:cinema_house/ui/screens/home_screen/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/dio_client.dart';
import 'features/lang/cubit/lang/lang_cubit.dart';
import 'features/lang/repositories/lang_repository.dart';
import 'ui/screens/login_screen/login_screen.dart';
import 'features/network/cubit/network_cubit.dart';
import 'features/lightMode/widgets/app_theme.dart';
import 'core/locator.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await EasyLocalization.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      assetLoader: const CodegenLoader(),
      supportedLocales: [
        Locale(LangStatus.en.text),
        Locale(LangStatus.uk.text)
      ],
      path: 'assets/translations',
      fallbackLocale: Locale(LangStatus.en.text),
      child: Builder(builder: (context) {
        locator<LangRepository>().context = context;
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: locator<NetworkCubit>()),
            BlocProvider.value(
              value: locator<LightModeCubit>(),
            ),
            BlocProvider.value(
              value: locator<AuthCubit>(),
            ),
            BlocProvider<LangCubit>(
              create: (_) => LangCubit(locator<LangRepository>()),
            ),
          ],
          child: BlocBuilder<LightModeCubit, bool>(builder: buildAppWithTheme),
        );
      }),
    );
  }

  MaterialApp buildAppWithTheme(BuildContext context, bool state) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Cinema House',
      theme: appThemes[state],
      initialRoute: (BlocProvider.of<AuthCubit>(context).state is AuthSuccess)
          ? '/home'
          : '/login',
      // named routes
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => HomeScreen(
            BlocProvider.of<NetworkCubit>(context).state is NetworkExists),
        // global named routes
      },
    );
  }
}
