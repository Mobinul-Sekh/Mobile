import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/common/components/custom_back_button.dart';
import 'package:bitecope/core/common/components/gradient_widget.dart';
import 'package:bitecope/core/common/components/snackbar_message.dart';
import 'package:flutter/material.dart';

class PageSelectorOption {
  String name;
  GestureTapCallback? onTap;

  PageSelectorOption({required this.name, this.onTap});
}

class PageSelector extends StatelessWidget {
  final Widget icon;
  final List<PageSelectorOption> pages;

  const PageSelector({
    Key? key,
    required this.icon,
    required this.pages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(
          icon: Icons.arrow_back_rounded,
        ),
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Please select one option",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: AppColors.shadowText),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors.lightGrey,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowBlack,
                      blurRadius: 12,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: _listPages(context),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 75,
        color: AppColors.lightGrey,
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () {
            Navigator.of(context).maybePop();
          },
          child: GradientWidget(
            gradient: AppGradients.primaryLinear,
            child: icon,
          ),
        ),
      ),
    );
  }

  List<Widget> _listPages(BuildContext context) {
    final List<Widget> _pages = [];
    for (int i = 0; i < pages.length; i++) {
      _pages.add(
        TextButton(
          onPressed: pages[i].onTap ??
              () {
                snackbarMessage(
                  context,
                  "Not Implemented Yet",
                  MessageType.warning,
                );
              },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                const Icon(Icons.circle_outlined, color: AppColors.nearBlack),
                const SizedBox(width: 12),
                Text(
                  pages[i].name,
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            ),
          ),
        ),
      );
    }
    return _pages;
  }
}
