import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../core/locale_keys.g.dart';
import '../../cubit/auth_cubit.dart';

class PhoneForm extends StatelessWidget {
  final AuthState authState;

  const PhoneForm({Key? key, required this.authState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(LocaleKeys.enterYourPhoneNumberToLoginViaSms.tr()),
        const SizedBox(height: 25),
        InternationalPhoneNumberInput(
          validator: (String? value) {
            if (value == null) {
              throw Exception(
                  "Set {autoValidateMode: AutovalidateMode.onUserInteraction}");
            }
            if (value.isEmpty) {
              return LocaleKeys.enterYourPhone.tr() ;
            }
            if (int.tryParse(value.replaceAll(" ", "")) == null) {
              return LocaleKeys.numbersAreRequired.tr();
            }
            return null;
          },
          keyboardType: TextInputType.number,
          selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.DROPDOWN,
              trailingSpace: false),
          autoValidateMode: AutovalidateMode.onUserInteraction,
          onInputChanged: (PhoneNumber value) {
            if ((value.dialCode!.length + 9) == value.phoneNumber!.length) {
              BlocProvider.of<AuthCubit>(context)
                  .sendPinOnPhoneNumber(value.phoneNumber!);
            }
          },
          inputDecoration: InputDecoration(
            hintText: LocaleKeys.phoneNumber.tr(),
          ),
          spaceBetweenSelectorAndTextField: 10,
          ignoreBlank: true,
          countries: const ["UA"],
          // formatInput: false,
          maxLength: 11,
        ),
        const SizedBox(height: 50),
        Text(
          authState.errorMessage,
          style: const TextStyle(color: Colors.redAccent),
        )
      ],
    );
  }
}
