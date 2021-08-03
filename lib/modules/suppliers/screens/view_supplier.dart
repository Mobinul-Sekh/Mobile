// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/modules/suppliers/models/supplier.dart';
import 'package:bitecope/widgets/block_button.dart';
import 'package:bitecope/widgets/custom_back_button.dart';
import 'package:bitecope/widgets/form_field_decoration.dart';
import 'package:bitecope/widgets/gradient_widget.dart';
import 'package:bitecope/widgets/required_field_label.dart';
import 'package:bitecope/widgets/snackbar_message.dart';
import 'package:bitecope/widgets/underlined_title.dart';

class ViewSupplier extends StatelessWidget {
  final Supplier supplier;

  const ViewSupplier({
    Key? key,
    required this.supplier,
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
            title: "Supplier Details",
            style: Theme.of(context).appBarTheme.textTheme?.headline6,
            underlineOvershoot: 0,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  childAspectRatio: 3 / 1,
                  padding: const EdgeInsets.all(12),
                  shrinkWrap: true,
                  children: [
                    _gridTile(
                      context,
                      text: "Supplier ID:",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: AppColors.black),
                    ),
                    _gridTile(
                      context,
                      text: supplier.id,
                    ),
                  ],
                ),
                const SizedBox(height: 36),
                requiredFieldLabel(
                  context,
                  labelText: "Supplier Name",
                ),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  style: Theme.of(context).textTheme.bodyText2,
                  initialValue: supplier.name,
                  readOnly: true,
                  decoration: formFieldDecoration(
                    context,
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 36),
                requiredFieldLabel(
                  context,
                  labelText: "Phone Number",
                ),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  style: Theme.of(context).textTheme.bodyText2,
                  initialValue: supplier.phoneNumber,
                  readOnly: true,
                  decoration: formFieldDecoration(
                    context,
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 36),
                requiredFieldLabel(
                  context,
                  labelText: "Address",
                ),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  style: Theme.of(context).textTheme.bodyText2,
                  initialValue: supplier.address,
                  readOnly: true,
                  minLines: 1,
                  maxLines: 3,
                  decoration: formFieldDecoration(
                    context,
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 36),
                requiredFieldLabel(
                  context,
                  labelText: "Description",
                  isRequired: false,
                ),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  style: Theme.of(context).textTheme.bodyText2,
                  initialValue: supplier.description,
                  readOnly: true,
                  minLines: 1,
                  maxLines: 6,
                  decoration: formFieldDecoration(
                    context,
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 36),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlockButton(
              onTap: () {
                //TODO
                snackbarMessage(
                  context,
                  "Not Implemented",
                  MessageType.warning,
                );
              },
              position: BlockPosition.left,
              child: const Center(
                child: GradientWidget(
                  gradient: AppGradients.primaryGradient,
                  child: Icon(
                    Icons.edit,
                    size: 36,
                  ),
                ),
              ),
            ),
            BlockButton(
              onTap: () {
                //TODO
                snackbarMessage(
                  context,
                  "Not Implemented",
                  MessageType.warning,
                );
              },
              position: BlockPosition.right,
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/delete.svg',
                  width: 36,
                  height: 36,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gridTile(
    BuildContext context, {
    required String text,
    TextStyle? style,
  }) {
    return Container(
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
          text,
          textAlign: TextAlign.center,
          style: style,
        ),
      ),
    );
  }
}
