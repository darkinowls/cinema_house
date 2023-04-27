import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_house/features/network/widgets/no_network_sign.dart';
import 'package:flutter/material.dart';

import '../../../features/auth/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: CachedNetworkImageProvider(
                  "https://c0.wallpaperflare.com/preview/523/511/794/building-city-street-cinema.jpg"),
              fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Center(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.2),
                    borderRadius: BorderRadius.circular(25)),
                width: 325,
                height: 325,
                padding: const EdgeInsets.all(25),
                child: const NoNetworkSign(elseChild: LoginForm()),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
