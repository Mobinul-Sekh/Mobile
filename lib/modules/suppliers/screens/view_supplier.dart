// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/modules/suppliers/models/supplier.dart';
import 'package:bitecope/widgets/custom_back_button.dart';
import 'package:bitecope/widgets/form_field_decoration.dart';
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
            InkWell(
              onTap: () {
                //TODO
                snackbarMessage(
                  context,
                  "Not Implemented",
                  MessageType.warning,
                );
              },
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Ink(
                width: 100,
                height: 60,
                decoration: const BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowBlack,
                      blurRadius: 12,
                      spreadRadius: 1,
                      offset: Offset(-3, 0),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.edit,
                    size: 36,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 2),
            InkWell(
              onTap: () {
                //TODO
                snackbarMessage(
                  context,
                  "Not Implemented",
                  MessageType.warning,
                );
              },
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: Ink(
                width: 100,
                height: 60,
                decoration: const BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowBlack,
                      blurRadius: 12,
                      spreadRadius: 1,
                      offset: Offset(3, 0),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.delete_forever_outlined,
                    size: 36,
                  ),
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
