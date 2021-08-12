// Flutter imports:
import 'package:bitecope/modules/home/screens/home_menu.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/common/components/gradient_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const HomeMenu(),
              ),
            );
          },
          child: SvgPicture.asset('assets/images/menu.svg'),
        ),
      ),
      body: const SafeArea(
        child: Center(
          child: Text("Home"),
        ),
      ),
      bottomSheet: Container(
        color: AppColors.lightGrey,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {},
              child: GradientWidget(
                gradient: AppGradients.primaryLinear,
                child: SvgPicture.asset('assets/images/home.svg'),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: SvgPicture.asset('assets/images/shipment.svg'),
            ),
            TextButton(
              onPressed: () {},
              child: SvgPicture.asset('assets/images/factory.svg'),
            ),
            TextButton(
              onPressed: () {},
              child: SvgPicture.asset('assets/images/addToList.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
