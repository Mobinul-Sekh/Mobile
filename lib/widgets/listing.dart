// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/widgets/custom_back_button.dart';
import 'package:bitecope/widgets/gradient_widget.dart';
import 'package:bitecope/widgets/snackbar_message.dart';
import 'package:bitecope/widgets/underlined_title.dart';

class Listing<T> extends StatelessWidget {
  final String title;
  final List<T>? data;
  final String Function(T) getText;
  final void Function(BuildContext, T)? onTap;
  final Widget? onEmpty;
  final Widget? onLoading;

  const Listing({
    Key? key,
    required this.title,
    this.data,
    required this.getText,
    this.onTap,
    this.onEmpty,
    this.onLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.lightGrey,
          leading: const CustomBackButton(
            icon: Icons.arrow_back_rounded,
            size: 28,
          ),
          title: UnderlinedTitle(
            title: title,
            style: Theme.of(context).appBarTheme.textTheme?.headline6,
            underlineOvershoot: 0,
          ),
        ),
        body: data == null
            ? onLoading ?? const Center(child: CircularProgressIndicator())
            : data!.isEmpty
                ? onEmpty ?? const Center(child: Text("Empty"))
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width ~/ 200,
                      crossAxisSpacing: 40,
                      mainAxisSpacing: 20,
                      childAspectRatio: 3 / 1,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 40,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (onTap != null) {
                            onTap!(context, data![index]);
                          }
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.lightGrey,
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.shadowBlack,
                                blurRadius: 12,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(6),
                          child: Center(
                            child: Text(
                              getText(data![index]),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(color: AppColors.black),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: data!.length,
                  ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            snackbarMessage(
              context,
              "Not Implemented",
              MessageType.warning,
            );
          },
          backgroundColor: AppColors.nearBlack,
          child: const GradientWidget(
            gradient: AppGradients.primaryGradient,
            child: Icon(Icons.add, size: 40),
          ),
        ),
      ),
    );
  }
}
