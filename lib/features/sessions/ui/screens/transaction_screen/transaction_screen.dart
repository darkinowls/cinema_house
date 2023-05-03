import 'package:cinema_house/features/sessions/domain/entities/card_form.dart';
import 'package:cinema_house/features/sessions/ui/screens/transaction_screen/transaction_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'formatters/card_month_input_formatter.dart';
import 'formatters/card_number_input_formatter.dart';

class TransactionScreen extends StatefulWidget {
  final int totalPrice;
  const TransactionScreen({Key? key, required this.totalPrice}) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(title: Text("${widget.totalPrice} UAH to be payed")),
      body: Padding(
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
                    decoration: const InputDecoration(
                      hintText: "Card number",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextFormField(
                      controller: email,
                      validator: TransactionUtils.validateEmail,
                      decoration: const InputDecoration(hintText: "Your email"),
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
                          decoration: const InputDecoration(hintText: "CVV"),
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
                          decoration: const InputDecoration(hintText: "MM/YY"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: (cardForm.isEmpty()) ? null : () {
                _formKey.currentState!.validate();
              },
              child: const Text("Pay via the card"),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
