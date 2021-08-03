// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/modules/suppliers/bloc/supplier_bloc.dart';
import 'package:bitecope/modules/suppliers/components/supplier_form.dart';
import 'package:bitecope/widgets/custom_back_button.dart';
import 'package:bitecope/widgets/gradient_button.dart';
import 'package:bitecope/widgets/underlined_title.dart';

class AddSupplier extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  AddSupplier({Key? key}) : super(key: key);

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
            title: "Add Supplier",
            style: Theme.of(context).appBarTheme.textTheme?.headline6,
            underlineOvershoot: 0,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: BlocConsumer<SupplierBloc, SupplierState>(
            listener: (context, state) {
              if (state.supplierStatus == SupplierStatus.done) {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  if (state.error != null)
                    Text(
                      state.error!(context)!,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: Theme.of(context).errorColor),
                    ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: SupplierForm(
                        nameController: _nameController,
                        nameError: state.name.error,
                        phoneNumberController: _phoneNumberController,
                        phoneNumberError: state.phoneNumber.error,
                        addressController: _addressController,
                        addressError: state.address.error,
                        descriptionController: _descriptionController,
                        descriptionError: state.description.error,
                        formMode: SupplierFormMode.create,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: GradientButton(
                      onTap: () {
                        context.read<SupplierBloc>().validateSupplier(
                              name: _nameController.text,
                              phoneNumber: _phoneNumberController.text,
                              address: _addressController.text,
                              description: _descriptionController.text,
                            );
                      },
                      backgroundGradient: AppGradients.primaryLinear,
                      child: state.supplierStatus == SupplierStatus.loading
                          ? const SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                              ),
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: AppColors.white,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  "Confirm",
                                  style: Theme.of(context).textTheme.button,
                                ),
                              ],
                            ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
