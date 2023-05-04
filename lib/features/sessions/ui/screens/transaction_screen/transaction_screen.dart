import 'package:cinema_house/core/locale_keys.g.dart';
import 'package:cinema_house/features/network/widgets/no_network_sign.dart';
import 'package:cinema_house/features/sessions/cubit/transactions/transaction_cubit.dart';
import 'package:cinema_house/features/sessions/domain/entities/card_form.dart';
import 'package:cinema_house/features/sessions/ui/screens/transaction_screen/transaction_utils.dart';
import 'package:cinema_house/ui/widgets/loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'formatters/card_month_input_formatter.dart';
import 'formatters/card_number_input_formatter.dart';

class TransactionScreen extends StatefulWidget {
  final int totalPrice;

  const TransactionScreen({Key? key, required this.totalPrice})
      : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final CardForm cardForm = CardForm();
  final TextEditingController email = TextEditingController();
  final TextEditingController cardNumber = TextEditingController();
  final TextEditingController expirationDate = TextEditingController();
  final TextEditingController cvv = TextEditingController();

  @override
  void initState() {
    email.addListener(() => setState(() => cardForm.email = email.text));
    cardNumber.addListener(
        () => setState(() => cardForm.cardNumber = cardNumber.text));
    expirationDate.addListener(
        () => setState(() => cardForm.expirationDate = expirationDate.text));
    cvv.addListener(() => setState(() => cardForm.cvv = cvv.text));
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    cardNumber.dispose();
    expirationDate.dispose();
    cvv.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NoNetworkSign(
      elseChild: Scaffold(
        appBar: AppBar(title: Text(LocaleKeys.uahToBePayed.tr(args:[widget.totalPrice.toString()]))),
        body: BlocBuilder<TransactionCubit, TransactionState>(
            builder: (context, state) {
          if (state.status == TransactionStatus.loading) {
            return const Loader();
          }
          if (state.status == TransactionStatus.failed) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 50),
                const SizedBox(height: 10),
                Text(
                    LocaleKeys.someErrorOccurred.tr()
                , style: const TextStyle(fontSize: 18))
              ],
            ));
          }
          if (state.status == TransactionStatus.success) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.gpp_good, size: 50),
                SizedBox(height: 10),
                Text(
                  LocaleKeys.theTransactionIsDone
                  ,
                    style: TextStyle(fontSize: 18))
              ],
            ));
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const Spacer(),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: cardNumber,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16),
                          CardNumberInputFormatter()
                        ],
                        validator: TransactionUtils.validateCardNumber,
                        decoration:  InputDecoration(
                          hintText:
                          LocaleKeys.cardNumber.tr()
                          ,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextFormField(
                          controller: email,
                          validator: TransactionUtils.validateEmail,
                          decoration:
                               InputDecoration(hintText:
                               LocaleKeys.yourEmail.tr()
                               ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: cvv,
                              obscureText: true,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                // Limit the input
                                LengthLimitingTextInputFormatter(3),
                              ],
                              validator: TransactionUtils.validateCVV,
                              decoration:
                                  const InputDecoration(hintText: "CVV"),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: expirationDate,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                                CardMonthInputFormatter()
                              ],
                              validator: TransactionUtils.validateDate,
                              decoration:
                                  const InputDecoration(hintText: "MM/YY"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: (cardForm.isEmpty())
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            cardForm.cardNumber =
                                TransactionUtils.getCleanedNumber(
                                    cardForm.cardNumber);
                            BlocProvider.of<TransactionCubit>(context)
                                .buySeats(cardForm);
                          }
                        },
                  child: Text(
                      LocaleKeys.payViaTheCard.tr()
                  ),
                ),
                const Spacer(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
