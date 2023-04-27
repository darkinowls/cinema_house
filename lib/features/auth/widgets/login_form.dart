import 'package:cinema_house/features/auth/widgets/forms/phone_form.dart';
import 'package:cinema_house/ui/screens/home_screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/widgets/loader.dart';
import '../cubit/auth_cubit.dart';
import 'forms/otp_form.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      builder: (context, state) {
        Widget? widget;
        if (state is PhoneNumberRequired || state is PhoneNumberError) {
          widget = PhoneForm(authState: state);
        }
        if (state is OTPRequired || state is OTPError) {
          widget = OtpForm(authState: state);
        }
        if (widget != null) {
          return Column(
            children: [
              const Text("Log in", style: TextStyle(fontSize: 36)),
              Expanded(child: Center(child: widget))
            ],
          );
        }
        return const Loader();
      },
    );
  }
}
