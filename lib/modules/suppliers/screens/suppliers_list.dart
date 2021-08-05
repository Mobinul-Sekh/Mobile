// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/authentication/bloc/authentication_bloc.dart';
import 'package:bitecope/core/common/components/action_button.dart';
import 'package:bitecope/core/common/models/user.dart';
import 'package:bitecope/core/common/screens/listing.dart';
import 'package:bitecope/modules/suppliers/bloc/supplier_bloc.dart';
import 'package:bitecope/modules/suppliers/bloc/supplier_list_bloc.dart';
import 'package:bitecope/modules/suppliers/models/supplier.dart';
import 'package:bitecope/modules/suppliers/screens/add_supplier.dart';
import 'package:bitecope/modules/suppliers/screens/view_supplier.dart';

class SuppliersList extends StatelessWidget {
  const SuppliersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupplierListBloc, SupplierListState>(
      builder: (context, state) {
        return Listing<Supplier>(
          title: AppLocalizations.of(context)!.suppliers,
          data: state.supplierListStatus == SupplierListStatus.loading
              ? null
              : state.suppliers,
          getText: (supplier) => supplier.name,
          onTap: (context, supplier) => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider<SupplierBloc>(
                create: (_) => SupplierBloc(
                  context.read<SupplierListBloc>().repository,
                ),
                child: ViewSupplier(supplier: supplier),
              ),
            ),
          ),
          actionButton: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state.authData!.userType == UserType.owner) {
                return ActionButton(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BlocProvider<SupplierBloc>(
                          create: (_) => SupplierBloc(
                            context.read<SupplierListBloc>().repository,
                          ),
                          child: AddSupplier(),
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.add,
                    size: 40,
                    color: AppColors.lightGrey,
                  ),
                );
              }
              return Container();
            },
          ),
        );
      },
    );
  }
}
