import 'package:cinema_house/features/sessions/domain/entities/card_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
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
  void didChangeDependencies() {
    email.dispose();
    cardNumber.dispose();
    expirationDate.dispose();
    cvv.dispose();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
