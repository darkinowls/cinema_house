import 'package:cinema_house/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpForm extends StatelessWidget {
  final AuthState authState;

  const OtpForm({Key? key, required this.authState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Enter the pin you have gotten via SMS"),
        const SizedBox(height: 15),
        PinCodeTextField(
          appContext: context,
          length: 4,
          cursorColor: Theme.of(context).focusColor,
          onChanged: (String value) {},
          keyboardType: TextInputType.number,
          onCompleted: (String pin) {
            BlocProvider.of<AuthCubit>(context).login(pin);
          },
        ),
        Text("Attempts: ${authState.pinAttempts}"),
        const SizedBox(height: 25),
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'Resend pin',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => BlocProvider.of<AuthCubit>(context)
                      .sendPinOnPhoneNumber(authState.phoneNumber)),
            TextSpan(
              style: TextStyle(color: Theme.of(context).focusColor),
              text: " if you didn't receive one",
            ),
          ]),
        ),
        const SizedBox(height: 15),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              style: TextStyle(color: Theme.of(context).focusColor),
              text: 'Wrong phone number? ',
            ),
            TextSpan(
                text: 'Go back',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).primaryColor,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => BlocProvider.of<AuthCubit>(context)
                      .returnToPhonePrompt()),
          ]),
        ),
      ],
    );
  }
}
