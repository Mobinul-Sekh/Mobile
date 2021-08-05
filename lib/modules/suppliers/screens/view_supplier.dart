// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/common/components/block_button.dart';
import 'package:bitecope/core/common/components/custom_back_button.dart';
import 'package:bitecope/core/common/components/gradient_widget.dart';
import 'package:bitecope/core/common/components/snackbar_message.dart';
import 'package:bitecope/core/common/components/underlined_title.dart';
import 'package:bitecope/modules/suppliers/components/supplier_form.dart';
import 'package:bitecope/modules/suppliers/models/supplier.dart';

class ViewSupplier extends StatefulWidget {
  final Supplier supplier;

  const ViewSupplier({
    Key? key,
    required this.supplier,
  }) : super(key: key);

  @override
  _ViewSupplierState createState() => _ViewSupplierState();
}

class _ViewSupplierState extends State<ViewSupplier> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _addressController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.supplier.name);
    _phoneNumberController =
        TextEditingController(text: widget.supplier.phoneNumber);
    _addressController = TextEditingController(text: widget.supplier.address);
    _descriptionController =
        TextEditingController(text: widget.supplier.description);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(
            icon: Icons.arrow_back_rounded,
            size: 28,
          ),
          title: UnderlinedTitle(
            title: AppLocalizations.of(context)!.supplierDetails,
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
                      text: AppLocalizations.of(context)!.supplierID,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: AppColors.black),
                    ),
                    _gridTile(
                      context,
                      text: widget.supplier.id,
                    ),
                  ],
                ),
                SupplierForm(
                  nameController: _nameController,
                  phoneNumberController: _phoneNumberController,
                  addressController: _addressController,
                  descriptionController: _descriptionController,
                ),
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
                  gradient: AppGradients.primaryLinear,
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
