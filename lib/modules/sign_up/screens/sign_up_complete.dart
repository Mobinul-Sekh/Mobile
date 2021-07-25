// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/widgets/rounded_wide_button.dart';

class SignUpComplete extends StatelessWidget {
  const SignUpComplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/images/party_hat.svg'),
                            const SizedBox(width: 12),
                            Text(
                              "Congratulations!",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                      color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 36),
                        Text(
                          "Account is successfully activated",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: AppColors.shadowText),
                        ),
                        const SizedBox(height: 50),
                        SvgPicture.asset('assets/images/celebration.svg'),
                        const SizedBox(height: 50),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyText2,
                            children: [
                              TextSpan(
                                text: "Thank you for choosing Bitecope. ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const TextSpan(
                                text:
                                    "Now you can continue using the services without any interruption.",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              RoundedWideButton(
                width: 310,
                onTap: () {
                  Navigator.of(context).popUntil(ModalRoute.withName('/'));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Go Back To Login",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: AppColors.white),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppGradients.primaryGradient,
                      ),
                      child: const Icon(Icons.arrow_forward_rounded),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
